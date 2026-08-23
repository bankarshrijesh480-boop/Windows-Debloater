# Windows Debloater Utility 🚀

A native, open-source PowerShell desktop dashboard utility designed to optimize performance, enhance privacy profiles, and safely remove pre-installed bloatware from clean Windows installations.

Built utilizing **Windows Forms (WinForms)**, this program offers a graphical point-and-click interface. You can target specific UWP ecosystem apps or background tracking scripts cleanly without touching raw lines of terminal text.

---

## ✨ Features Dashboard

*   **Modular Bloatware Removal:** Check boxes to uninstall specific targets (e.g., Bing News, Solitaire, Xbox Sync tools) without corrupting your core Microsoft Store functions.
*   **Privacy & Telemetry Lockdowns:** Disables data collection trackers (`DiagTrack`) and limits background logging loops.
*   **Safe Execution Safeguards:** Built-in programmatic checks ensure tasks never fail due to missing system rights.
*   **Fully Transparent:** Auditable source code built on native Windows binaries. No unverified third-party executables (`.exe`) required.

---

## ⚠️ Safety Precautions

Before applying any operational system tweaks:
1. **Create a System Restore Point:** Always open Windows Search, search for "Create a restore point," and create a snapshot image before executing adjustments.
2. **Review Options Carefully:** Only apply modifications that match your daily operational workflow needs.

---

## 🚀 Quick Deployment Guide

Because Microsoft blocks remote execution frameworks by default, deploy this utility via an elevated local terminal window.

1. Right-click your Windows Start button and choose **Terminal (Admin)** or **PowerShell (Admin)**.
2. Authorize temporary script execution access flags for your active shell window process:
   ```powershell
   Set-ExecutionPolicy Unrestricted -Scope Process -Force
   ```
3. Run the primary interface launcher:
   ```powershell
   .\src\debloat_gui.ps1
   ```

---

## 🤝 Community Inspiration & References
If you require massive, enterprise-grade system control panels, investigate the active codebases maintained by these community leaders:
*   [Chris Titus Tech - Windows Utility Tool (WinUtil)](https://github.com)
*   [Sophia Script for Windows Ecosystem](https://github.com)

---

## 📄 License

This codebase is licensed under the MIT License - see the [LICENSE](LICENSE) file for exact parameters.

### Permissive Allowances:
*   **✅ Commercial/Personal Use:** Deploy across production client fleets or home machinery freely.
*   **✅ Open Modification:** Fork, alter, or inject alternative PowerShell algorithms into this foundation.
*   **❌ No Liability:** This system toolkit is deployed "as is" without warranty parameters.
