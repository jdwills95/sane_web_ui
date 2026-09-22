#!/bin/bash

# Function to run scanimage with customizable file format, output file name, and scan source
scan_image() {
    local file_format="$1"       # Accept file format (e.g., png, tiff, pdf)
    local file_name="$2"         # Accept name for the scan (e.g., scannedimage_...)
    local source="${3:-Flatbed}" # Accept scan source (e.g., Flatbed or ADF, default: Flatbed)

    # Define the folder where the file will be saved
    local scan_folder="${SCAN_DIR:-$HOME/scans}"

    # Ensure the folder exists (create it if it doesn't)
    mkdir -p "$scan_folder"

    # Append the file format extension to the file name
    local output_file="$scan_folder/$file_name.$file_format"

    # Create a temporary directory for multi-page batch scanning
    local temp_dir
    temp_dir=$(mktemp -d "$scan_folder/.tmp_scan_XXXXXX") || return 1

    # Run scanimage with batch mode to capture all pages from ADF or Flatbed
    scanimage -d escl:http://localhost:60000 --source "$source" --mode Color --resolution 300 --format="$file_format" --batch="$temp_dir/page_%04d.$file_format"
    local scan_status=$?

    # Find all scanned page files in order
    shopt -s nullglob
    local pages=("$temp_dir"/page_*."$file_format")
    shopt -u nullglob

    if [[ ${#pages[@]} -eq 0 ]]; then
        echo "Error: No pages were scanned."
        rm -rf "$temp_dir"
        return 1
    fi

    local merge_status=0

    if [[ ${#pages[@]} -eq 1 ]]; then
        mv "${pages[0]}" "$output_file"
        merge_status=$?
    else
        case "$file_format" in
            pdf)
                if command -v pdfunite >/dev/null 2>&1; then
                    pdfunite "${pages[@]}" "$output_file"
                    merge_status=$?
                elif command -v img2pdf >/dev/null 2>&1; then
                    img2pdf "${pages[@]}" -o "$output_file"
                    merge_status=$?
                elif command -v convert >/dev/null 2>&1; then
                    convert "${pages[@]}" "$output_file"
                    merge_status=$?
                else
                    mv "${pages[0]}" "$output_file"
                    merge_status=$?
                fi
                ;;
            tiff|tif)
                if command -v tiffcp >/dev/null 2>&1; then
                    tiffcp "${pages[@]}" "$output_file"
                    merge_status=$?
                elif command -v convert >/dev/null 2>&1; then
                    convert "${pages[@]}" "$output_file"
                    merge_status=$?
                else
                    mv "${pages[0]}" "$output_file"
                    merge_status=$?
                fi
                ;;
            png)
                if command -v convert >/dev/null 2>&1; then
                    convert -append "${pages[@]}" "$output_file"
                    merge_status=$?
                else
                    mv "${pages[0]}" "$output_file"
                    merge_status=$?
                fi
                ;;
            *)
                mv "${pages[0]}" "$output_file"
                merge_status=$?
                ;;
        esac
    fi

    # Clean up temporary directory
    rm -rf "$temp_dir"

    # Check if output file was created successfully
    if [[ $merge_status -eq 0 && -f "$output_file" ]]; then
        echo "Scan completed successfully. Output saved to $output_file"
        return 0
    else
        echo "Error occurred during scan processing or merging."
        return 1
    fi
}

# Call the function with arguments passed to the script
scan_image "$1" "$2" "$3"
