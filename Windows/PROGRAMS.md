somni.dotfiles ― Windows programs
=================================

## ❌ DO NOT INSTALL
- **NVIDIA GeForce Experience**
  - Kind of shit for a long time

## Standalone Installable Programs
### Runtime
- **DirectX end-user runtime**
  - https://www.microsoft.com/ko-kr/download/details.aspx?id=35
- **.NET Desktop Runtime**
  - https://dotnet.microsoft.com/ko-kr/download/dotnet
  - Install latest stable, supported build. **No need to install this if planning to install .NET SDK.**

### System Utilities
- **Windows Terminal**
  - https://github.com/microsoft/terminal
  - Install latest stable release.
  - Use this as default console host.
  - **DON'T INSTALL THIS FROM MICROSOFT STORE.** Outdated version published on there.
  - Ensure the version is at least **v1.13**.
- **Microsoft PowerToys**
  - https://github.com/microsoft/PowerToys
- **NanaZip**
  - https://github.com/M2Team/NanaZip
  - Install MSIX package of latest preview(if available) version from GitHub Releases instead of from Microsoft Store.
- **IconViewer**
  - https://www.botproductions.com/iconview/download.html
- **VeraCrypt**
  - https://www.veracrypt.fr/en/Downloads.html
- **VMware Workstation Player**
  - https://www.vmware.com/products/workstation-player/workstation-player-evaluation.html
- **Parsec**
  - https://parsec.app/

### Web
- **Microsoft Edge Beta**
  - https://www.microsoftedgeinsider.com/ko-kr/download/beta
  - Disable/Remove all of bloatwa

### Development
- **Visual Studio Code**
  - https://code.visualstudio.com/Download
  - Install using System Installer.
- **Git (git-scm)**
  - https://git-scm.com/download/win
- **Gpg4win**
  - https://gpg4win.org/download.html
- **Keybase**
  - https://keybase.io/download
- **Node.js** (via `nvm-windows`)
  - https://github.com/coreybutler/nvm-windows
  - Install latest LTS using `> nvm install lts` command after installing `nvm-windows`.<br/>**NOTE**: `nvm-windows` is intended to be replaced by [`Runtime`](https://github.com/coreybutler/nvm-windows/wiki/Runtime) someday.
- **Python**
  - https://www.python.org/downloads/windows/
  - Install using Windows Installer of latest major version.
- **.NET SDK**
  - https://dotnet.microsoft.com/ko-kr/download/dotnet
  - Install latest stable, supported build.
- **Unity Hub**
  - https://unity.com/download
  - Install latest LTS editor after installing the Hub.
- **Visual Studio**
  - https://visualstudio.microsoft.com/downloads/
  - Use latest version of Community edition. Select "at least" `.NET Desktop Development`, `Game Development with Unity`(uncheck Unity Hub) workloads.

### SNS / Messenger
- **Discord**
  - https://discord.com/download

### File Transfer & Sync
- **Bitwarden**
  - https://bitwarden.com/
  - Also install web browser extension.
- **Google Drive**
  - https://www.google.com/drive/download/
- **OneDrive** *(if needed)*
  - Use Windows 10/11 built-in software.
- **Notion**
  - https://www.notion.so/
- **qBittorrent**
  - https://www.qbittorrent.org/download

### Media
- **LAV Filters**
  - https://files.1f0.de/lavf/nightly/
  - Use latest nightly build.
  - Set hardware decoder to `D3D11` in video decoder settings.
- **MPC-HC**
  - https://github.com/clsid2/mpc-hc
  - Use maintained version by [clsid2](https://github.com/clsid2).
- **MusicBee**
  - https://www.getmusicbee.com/
  - Can be updated to latest in-development version. Incremental update packages are available at [the forum](https://getmusicbee.com/forum/index.php?board=6.0)
- **Spotify**
  - https://www.spotify.com/download/windows/
- **ImageGlass**
  - https://imageglass.org/
  - **Use the version at least v9.0.** v8.x has laggy UI.
  - Use this as default image viewer.
  - Add-ons
    - **ExifGlass**
      - https://github.com/d2phap/ExifGlass
      - Install onto ImageGlass installation.

### Gaming
- **Steam**
  - https://store.steampowered.com/about/
- **MSI Afterburner**
  - https://www.msi.com/Landing/afterburner/graphics-cards
  - Install only when need to adjust GPU voltage/clock curve.

---

## From Microsoft Store

---

## Portable(no installer) Programs
> These programs does not have executable installer, or just personal preference, so should be installed manually by unzipping the program archive somewhere.

### System Utilities
- **aria2**
  - https://github.com/aria2/aria2
  - Unzip into somewhere and register directory path in `%PATH%`.
- **ExifTool**
  - https://exiftool.org/
  - Unzip into somewhere and register directory path in `%PATH%`.
  - This is a dependency of **ExifGlass**.
- **OpenRGB**
  - https://openrgb.org/
  - Use this for ARGB sync instead of vendor specific programs (a.k.a. "shit").
- **RunCat**
  - https://github.com/Kyome22/RunCat_for_windows

### Development
- **Android Platform Tools**
  - https://developer.android.com/studio/releases/platform-tools
  - Unzip into somewhere and register directory path in `%PATH%`.
- **MobaXterm**
  - https://mobaxterm.mobatek.net/
  - Use Home Edition. Use Preview version if available.

### Media
- **madVR**
  - http://madvr.com/
  - Unzip into somewhere and egister video renderer using `install.bat`.

---

## Progressive Web Applications
### File Transfer & Sync
- **Google Keep**
  - https://keep.google.com/
