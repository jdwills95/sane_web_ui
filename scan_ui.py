import os
import subprocess
import datetime
from flask import Flask, render_template, send_from_directory
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

app = Flask(__name__)

# Fetch settings from the environment variables
SCAN_DIR = os.getenv("SCAN_DIR", "/home/darth/scans")  # Default to /home/darth/scans if not set
PORT = int(os.getenv("PORT", 5000))  # Default to port 5000 if not set

# Make sure the scan directory exists
os.makedirs(SCAN_DIR, exist_ok=True)

# Function to scan the image
def scan_image(file_type, file_name):
    """ Simulate the scanning process by running the bash function """
    command = f"scanimage --mode Color --resolution 300 --format={file_type} > {SCAN_DIR}/{file_name}.{file_type}"
    try:
        subprocess.run(command, shell=True, check=True)
        return True
    except subprocess.CalledProcessError:
        return False

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/scan', methods=['POST'])
def scan():
    timestamp = datetime.datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
    file_type = 'png'  # Default to png, can be modified based on form input
    file_name = f'scannedimage_{timestamp}'
    
    if scan_image(file_type, file_name):
        return render_template('success.html', file_name=file_name, file_type=file_type)
    else:
        return render_template('failure.html')

@app.route('/download/<file_name>')
def download(file_name):
    # Send the generated file to the user
    file_path = os.path.join(SCAN_DIR, f"{file_name}.png")
    return send_from_directory(SCAN_DIR, f"{file_name}.png", as_attachment=True)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=PORT)
