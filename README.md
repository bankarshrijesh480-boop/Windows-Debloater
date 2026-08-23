# Windows Debloater PowerShell Script 🚀

A lightweight, transparent, and modular PowerShell automation script designed to optimize performance, enhance privacy, and declutter a fresh installation of Windows 10 and Windows 11.

Unlike heavy, compiled binaries, this tool uses clear, open-source PowerShell commands so you can audit exactly what registry keys and packages are being altered.

## ✨ Core Features

*   **Bloatware Removal:** Safely uninstalls non-essential pre-installed UWP apps (e.g., Bing News, Solitaire, Skype) without breaking the Microsoft Store.
*   **Privacy & Telemetry Controls:** Disables background tracking services (`DiagTrack`) and restricts diagnostic data logging.
*   **Cortana Deactivation:** Toggles Windows registry variables to turn off Cortana search indexing features.
*   **Safe Execution Environment:** Contains strict privilege checks to prevent execution errors outside of administrative mode.

## ⚠️ Important Precautions

Before executing this script, you must read the following rules:
1. **Create a System Restore Point:** Always backup your current OS configuration before applying tweaks.
2. **Review the Code:** Open `debloat.ps1` and manually comment out (`#`) any application or service you wish to keep.

## 🚀 Quick Start Guide

Since Windows restricts remote scripts by default, run this utility locally using an elevated terminal session.

1. Open **PowerShell (Admin)** or **Windows Terminal (Admin)**.
2. Allow temporary local script execution policies for your current process:
   ```powershell
   Set-ExecutionPolicy Unrestricted -Scope Process -Force
   ```
3. Clone or download this repository, change directories into the script path, and deploy:
   ```powershell
   .\debloat.ps1
   ```

## 🛠️ Modifying & Personalizing The Script

This code is written modularly. If you need to keep specific tools—like the Xbox app or the default Weather widget—simply delete their specific string identifiers from the `$AppsToRemove` array block.

```powershell
\$AppsToRemove = @(
    "Microsoft.BingNews",
    # "Microsoft.BingWeather",  <-- Commenting this out saves your Weather app!
    "Microsoft.GetHelp"
)
```

## 🤝 Contributions & Alternatives
If you are looking for advanced, feature-rich graphical interfaces built by the community, feel free to inspect the engineering patterns used by [Chris Titus Tech's WinUtil](https://github.com/ChrisTitusTech/winutil) or the [Sophia Script for Windows Ecosystem](https://github.com/farag2/Sophia-Script-for-Windows). Pull requests for new app packages are welcome!

