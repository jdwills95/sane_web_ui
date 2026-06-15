---
name: ssh-printserver
description: Instructions and context for interacting with the Printserver where the sane_web_ui application is deployed.
---

# SSH Printserver Skill

Use this skill when you need to perform actions on the remote Printserver where the `sane_web_ui` application actually runs. This includes deploying changes, restarting services, or troubleshooting the application in its production environment.

## Context

- **Remote Host:** `Printserver` (accessible via `ssh Printserver`)
- **App Path:** `/home/darth/sane_web_ui`
- **User:** `darth`
- **Deployment Note:** The application is NOT intended to run locally on the development machine. Always use the Printserver for execution and verification of changes.

## Common Operations

### Restarting the Service
The application runs as a system-wide systemd service named `scan-app.service`. To restart it after making changes:
```bash
ssh Printserver "sudo systemctl restart scan-app.service"
```

### Syncing Changes
To copy local changes to the Printserver (e.g., `app.py`):
```bash
scp app.py Printserver:/home/darth/sane_web_ui/
```
*Note: After syncing, you typically need to restart the service.*

### Checking Logs
To view the application logs:
```bash
ssh Printserver "journalctl -u scan-app.service -f"
```

### Scanner Status
To check if the scanner is detected and recognized by the Printserver:
```bash
ssh Printserver "scanimage -L"
```

### Running Verification Tests
Tests should be run on the Printserver to ensure they interact with the actual hardware/environment:
```bash
ssh Printserver "cd /home/darth/sane_web_ui && /usr/bin/python3 <test_file>.py"
```

## Guidelines
- **No Local Run:** Do not attempt to run or test the scanning functionality on the local development machine.
- **Service Management:** Always restart `scan-app.service` after updating code on the Printserver.
- **Hardware Access:** The Printserver is the only machine with the scanner connected and configured.
