# Scan Web UI

This project provides a lightweight web interface for scanning documents or images on any Linux system with a scanner connected. Users can scan images in different formats (`PNG`, `TIFF`, `PDF`) and download the scanned images directly from the web interface.

## Features

- **Web Interface**: A simple web UI built using Flask to scan images from a connected scanner.
- **Customizable Formats**: Choose between PNG, TIFF, and PDF formats.
- **File Download**: Download the scanned image once the scan is complete.

## Requirements

- **Linux**: Works on any Debian-based or Arch-based Linux distribution.
- **Python 3**: The project is built using Python 3 and the Flask web framework.
- **SANE (Scanner Access Now Easy)**: To interface with scanners using the `scanimage` command.

## Installation

### Install Required Packages

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

### Install Python Dependencies

Clone the repository and install the required Python libraries:

```bash
git clone https://github.com/your-username/sane_web_ui.git
cd sane_web_ui
pip3 install -r requirements.txt
```

## Running the Application

1. **Set Up the `.env` File**:
   - Ensure you have a `.env` file in your project directory with the necessary environment variables set, including `SCAN_DIR` (where the scans will be saved) and `PORT` (the port the server will listen on).
   
   Example `.env` file:
   ```env
   SCAN_DIR=/path/to/scans
   PORT=5000
   ```
2. **Navigate to the Project Directory**:
   - Open a terminal and `cd` into the `sane_web_ui` directory (where the `app.py` script is located).
   
   ```bash
   cd /path/to/sane_web_ui
   ```

2. **Run the Application in the Background with `nohup` and `Gunicorn`**:
   - Use the following `nohup` command to run the application with `Gunicorn` in the background. This will allow the application to continue running even after you close the terminal.
   
   ```bash
   nohup sudo gunicorn -w 4 -b 0.0.0.0:$(grep PORT .env | cut -d '=' -f2) --timeout 300 app:app &
   ```

### Project Directory

Directory structure:

```
/home/username/sane_web_sane/
├── app.py                  # Main Python script
├── .env                    # Environment variables
├── assets/                 # Directory containing static assets like CSS/JS/images
│   ├── style.css
│   └── script.js
└── templates/              # HTML templates
    ├── index.html
    ├── success.html
    └── failure.html
```

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
