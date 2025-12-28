---
sidebar_position: 5
---

# Cài đặt extension offline với VSCode

## Step 1: Download Extension
You can construct the .vsix download URL by hand.

`Step 1:` Get extension's "Unique Identifier", and split it into two parts along the .: eg. ms-python.python becomes ms-python and python

`Step 2:` Get a version from "Version History" tab on marketplace. eg. 2024.17.2024100401

`Step 3:` Determine the binary type that you need. Skip this step if this extension is "Universal". Note that some extensions do not support all binary types.

| Binary type         | targetPlatform |
| ------------------- | -------------- |
| Alpine Linux 64 bit | `alpine-x64`   |
| Alpine Linux ARM64  | `alpine-arm64` |
| Linux ARM32         | `linux-armhf`  |
| Linux ARM64         | `linux-arm64`  |
| Linux x64           | `linux-x64`    |
| Windows ARM         | `win32-arm64`  |
| Windows x64         | `win32-x64`    |
| macOS Apple Silicon | `darwin-arm64` |
| macOS Intel         | `darwin-x64`   |

`Step 4:` combine

https://marketplace.visualstudio.com/_apis/public/gallery/publishers/ms-python/vsextensions/python/2024.17.2024100401/vspackage?targetPlatform=win32-x64

The ?targetPlatform=win32-x64 part is optional, if your extension is universal.

Download in linux
```
curl  https://marketplace.visualstudio.com/_apis/public/gallery/publishers/ms-python/vsextensions/python/2024.17.2024100401/vspackage?targetPlatform=linux-x64 -O -J

curl  https://marketplace.visualstudio.com/_apis/public/gallery/publishers/ms-vscode/vsextensions/cpptools/1.26.1/vspackage?targetPlatform=linux-x64 -O -J
```

## Cài đặt màn hình VSCode startup luôn là Welcome Page
### Method 1: Using the Settings UI (Recommended)
- Open VS Code.   
- Go to `File` > `Preferences` > `Settings` (or use the shortcut `Ctrl+,`).   
- In the search bar at the top, type `startup editor`.   
- Under `Workbench` > `Startup Editor`, select `Welcome Page` from the dropdown menu.    
- Next, search for `restoreWindows` in the settings search bar.   
- Under `Window` > `Restore Windows`, select `None` from the dropdown menu.    
### Method 2: Editing settings.json
- For users who prefer editing the raw JSON file, you can directly add the following lines to your settings.json file:    
- Open the Command Palette (Ctrl+Shift+P) and type Open User Settings (JSON).   
- Add the following lines to the JSON object:   
```json
"workbench.startupEditor": "welcomePage",
"window.restoreWindows": "none"
```

`Reference:`   
https://stackoverflow.com/a/79565372/14312225  
