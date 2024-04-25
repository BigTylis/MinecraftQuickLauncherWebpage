@echo off
setlocal

set "url=%~1"

for /f "tokens=2,3,4,5 delims=/" %%a in ("%url%") do (
    set "requiredlauncherversion=%%a"
    set "gametype=%%b"
    set "version=%%c"
    set "server=%%d"
)

set /p currentLauncherVersion=<%~dp0Launcher-Version.txt

:: Check for new versions and download updates if needed
set "updateDir=%USERPROFILE%\MinecraftLaunchScheme-Updater"
if not "%requiredlauncherversion%" == "%currentLauncherVersion%" (
    echo New version of the launcher is out! Press any key to begin the update.
    pause

    if exist %updateDir% rmdir /s /q %updateDir%
    mkdir %updateDir%

    start /wait curl -L -o %updateDir%\Install.bat "https://bigtylis.github.io/MinecraftQuickLauncher/Files/Install.bat"
    start /wait curl -L -o %updateDir%\LaunchApplication.zip "https://bigtylis.github.io/MinecraftQuickLauncher/Files/LaunchApplication.zip"
    start /wait curl -L -o %updateDir%\Update.bat "https://bigtylis.github.io/MinecraftQuickLauncher/Files/Update.bat"

    if exist "%updateDir%\Install.bat" (
        echo Install.bat downloaded successfully.
    ) else (
        echo Install.bat download failed.
	pause
	exit
    )
    if exist "%updateDir%\LaunchApplication.zip" (
        echo LaunchApplication.zip downloaded successfully.
    ) else (
        echo LaunchApplication.zip download failed.
	pause
	exit
    )
    if exist "%updateDir%\Update.bat" (
        echo Update.bat downloaded successfully.
    ) else (
        echo Update.bat download failed.
	pause
	exit
    )

    start "" "%updateDir%\Update.bat"
    exit
)

start "" %~dp0MinecraftQuickLauncher.exe %gametype% %version% %server%
start "" https://bigtylis.github.io/MinecraftQuickLauncher/Webpage.html?arg1=returnEndpointSuccess