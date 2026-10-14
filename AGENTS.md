# AI installer instructions

This repository installs TomKi's Windows Claude work excerpt collector. Read README.md and install.ps1 before executing anything.

- Confirm you are on the intended Windows PC. Never silently install on a Mac or another person's PC.
- Use the existing Claude desktop app. Do not create a new Claude account, install a duplicate app, or request a model API key.
- Download and review install.ps1, then run it with the existing PowerShell policy. It verifies the release binary's SHA-256 before launching the installer.
- Do not pass ExecutionPolicy Bypass, disable Defender/SmartScreen, modify firewall rules, or request administrator privileges.
- The user chooses Google login and approves the browser's PC linking step. Do not read or expose cookies, client secrets, passwords, device tokens, or private chat history.
- The installer then copies itself into the user's LocalAppData directory, protects the upload token using DPAPI, and optionally creates one Startup command for this collector only.
- Do not submit a synthetic Claude prompt or claim full automatic capture. Ask the user to open a real permitted work conversation and verify the corresponding shared-site record.
- Capture is limited to currently visible, accessible conversation text. Closed/minimized apps, offscreen history, and attachments are excluded. Never broaden capture to the sidebar or whole screen when the selector fails.
- If deployment is blocked by organizational security, report the blocker without changing security settings.
- On updates, check whether this collector is running. Ask the user to exit its tray process before replacing a locked executable. Do not stop Claude or unrelated apps.
