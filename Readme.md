# Scan Web UI

This project provides a lightweight web interface for scanning documents or images on any Linux system with a scanner connected. Users can scan images in different formats (`PNG`, `TIFF`, `PDF`) and download the scanned images directly from the web interface.

## Features

- **Web Interface**: A simple web UI built using Flask to scan images from a connected scanner.
- **Customizable Formats**: Choose between PNG, TIFF, and PDF formats.
- **Loading Animation**: Displays a loading spinner while the scan is in progress.
- **File Download**: Download the scanned image once the scan is complete.
- **Button Disablement**: The "Scan" button is disabled once clicked to prevent multiple submissions.
- **Local Asset**: The loading spinner is served locally from a `spinner.gif` file.

## Requirements

- **Linux**: Works on any Debian-based or Arch-based Linux distribution.
- **Python 3**: The project is built using Python 3 and the Flask web framework.
- **SANE (Scanner Access Now Easy)**: To interface with scanners using the `scanimage` command.

## Installation

### 1. Install Required Packages

#### On Debian/Ubuntu-based systems:
```bash
sudo apt update
sudo apt install python3-pip sane-utils
```

#### On Arch-based systems:
```bash
sudo pacman -S python-pip sane
```

- `python3-pip`: The Python package manager for installing Flask.
- `sane-utils`: Tools for scanning (including `scanimage`).

### 2. Install Python Dependencies

Clone the repository and install the required Python libraries:

```bash
git clone https://github.com/your-username/sane_web_ui.git
cd sane_web_ui
pip3 install -r requirements.txt
```

Create a `requirements.txt` file with the following dependencies:

```
Flask
```

### 3. Set Up the Project Directory

Ensure the following directory structure:

```
/home/username/sane_web_sane/
│
├── assets/
│   └── spinner.gif   # Your spinner GIF file
│
├── scans/            # Directory where scanned images are saved
│
└── scan_ui.py        # Flask app script
└── templates/
    └── index.html    # Your HTML file
    └── success.html  # Success page template
    └── failure.html  # Failure page template
```

### 4. Place the Spinner GIF

Place your `spinner.gif` file into the `/home/username/sane_web_sane/assets/` directory. You can download a GIF from a free source or create your own loading animation.

### 5. Run the Flask App

To run the web application, execute the following command:

```bash
python3 /home/username/sane_web_sane/scan_ui.py
```

This will start the Flask server, and the app will be accessible from any device on the same network at `http://<your-linux-machine-ip>:5000/`.

### 6. Configure SANE (Optional)

If your scanner is not detected by the `scanimage` command, you may need to configure SANE. Check your scanner's documentation for setup instructions or refer to the [SANE website](http://www.sane-project.org/).

### 7. Access the Web UI

- Open a browser and navigate to `http://<your-linux-machine-ip>:5000/`.
- Select the desired file format (PNG, TIFF, or PDF) from the dropdown.
- Click the "Scan" button, and the scanner will begin scanning.
- The "Scan" button will be disabled, and a loading spinner will be shown while the scan is in progress.
- Once the scan completes, you will see a success or failure page, with an option to download the scanned image.

## File Structure

### 1. `scan_ui.py`

This is the main Flask application script. It handles:
- Starting the Flask web server.
- Running the `scanimage` command.
- Serving the static spinner image.
- Handling user requests for scanning and downloading.

### 2. `index.html`

This is the main web page. It provides:
- A dropdown for the user to select the image format (`PNG`, `TIFF`, or `PDF`).
- A button to initiate the scan.
- A loading spinner that is displayed while the scan is in progress.

### 3. `assets/spinner.gif`

A local loading spinner GIF that is displayed when the scanning process is running.

### 4. `templates/`

This folder contains the HTML templates:
- `index.html`: The main form to choose the scan format and trigger the scan.
- `success.html`: Displays after a successful scan, with a link to download the image.
- `failure.html`: Displays if the scan fails.

### 5. `scans/`

This directory stores the scanned images. The scanned images will be saved here with a timestamp and the selected file format.

## Usage

1. Navigate to `http://<your-linux-machine-ip>:5000/` from a browser.
2. Select a file type (PNG, TIFF, or PDF).
3. Click the **Scan** button to begin scanning.
4. Wait for the scan to finish (the button will be disabled, and a loading spinner will appear).
5. Once the scan completes, download the image from the success page.

## Troubleshooting

- **Scan Command Not Found**: Ensure that the `scanimage` command is available by running `scanimage --help` in the terminal.
- **Scanner Not Detected**: Make sure your scanner is properly connected and recognized by the SANE system. You can check available devices using `scanimage -L`.
- **Permissions Issues**: If you encounter permission errors when accessing the scanner, try running the Flask app as a superuser (`sudo python3 scan_ui.py`), or adjust the permissions for your scanner device.

## License

This project is open-source and available under the MIT License. See the LICENSE file for more details.
