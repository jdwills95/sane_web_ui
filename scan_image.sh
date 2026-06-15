#!/bin/bash

# Function to run scanimage with customizable file format and output file name
scan_image() {
    local file_format="$1"    # Accept file format (e.g., png)
    local file_name="$2"      # Accept name for the preview scan (e.g., preview_scan.png)

    # Define the folder in the user's home directory where the file will be saved
    local scan_folder="$HOME/scans"

    # Ensure the folder exists (create it if it doesn't)
    mkdir -p "$scan_folder"

    # Append the file format extension to the file name
    local output_file="$scan_folder/$file_name.$file_format"

    # Run scanimage with the provided parameters and save the output to the file
    # scanimage --mode Color --resolution 300 --format="$file_format" > "$output_file"
    scanimage -d escl:http://localhost:60000 --mode Color --resolution 300 --format="$file_format" > "$output_file"

    # Check if the command was successful
    if [[ $? -eq 0 ]]; then
        echo "Scan completed successfully. Output saved to $output_file"
    else
        echo "Error occurred during scan."
    fi
}

# Call the function with arguments passed to the script
scan_image "$1" "$2"
