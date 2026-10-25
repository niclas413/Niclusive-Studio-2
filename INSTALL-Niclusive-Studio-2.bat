@echo off
setlocal EnableExtensions EnableDelayedExpansion
chcp 65001 >nul
title Niclusive Music Studio 2 - Installer
color 0B
set "APPNAME=Niclusive Studio 2"
set "ZIP=%~dp0Niclusive-Studio-2-Windows-Portable.zip"
set "DEST=%LOCALAPPDATA%\Programs\Niclusive Studio 2"
set "STAGE=%TEMP%\NiclusiveStudio2-Setup-%RANDOM%-%RANDOM%"
set "LOG=%TEMP%\NiclusiveStudio2-Setup.log"
set "SOURCE="
set "APP=%DEST%\Niclusive Studio 2.exe"
>"%LOG%" echo Niclusive Studio 2 Installer - %DATE% %TIME%
echo.
echo ==========================================================
echo              NICLUSIVE MUSIC STUDIO 2
echo                     INSTALLER
echo ==========================================================
echo.
echo This installer installs Studio 2 separately from any older version.
echo Existing files in the target folder are backed up before updating.
echo.
if not exist "%ZIP%" (
  echo ERROR: Install package not found.
  echo Place "Niclusive-Studio-2-Windows-Portable.zip" next to this BAT file.
  pause
  exit /b 1
)
where powershell.exe >nul 2>&1
if errorlevel 1 (
  echo ERROR: Windows PowerShell was not found.
  pause
  exit /b 1
)
echo Checking ZIP archive...
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='Stop'; Add-Type -AssemblyName System.IO.Compression.FileSystem; $z=[IO.Compression.ZipFile]::OpenRead('%ZIP%'); try { if ($z.Entries.Count -lt 10) { throw 'Too few ZIP entries' }; if ($null -eq $z.GetEntry('Niclusive Studio/Niclusive Studio 2.exe')) { throw 'EXE missing' }; if ($null -eq $z.GetEntry('Niclusive Studio/resources/app.asar')) { throw 'app.asar missing' }; Write-Output ('ZIP OK: '+$z.Entries.Count+' entries') } finally { $z.Dispose() }" >>"%LOG%" 2>&1
if errorlevel 1 (
  echo ERROR: ZIP is incomplete or has an unexpected folder structure.
  echo Details: "%LOG%"
  pause
  exit /b 1
)
if not exist "%LOCALAPPDATA%\Programs" mkdir "%LOCALAPPDATA%\Programs" >nul 2>&1
if not exist "%LOCALAPPDATA%\Programs" (
  echo ERROR: Could not create installation folder.
  pause
  exit /b 1
)
set /p "CUSTOM=Enter another target folder or press ENTER for default: "
if not "%CUSTOM%"=="" set "DEST=%CUSTOM%"
set "APP=%DEST%\Niclusive Studio 2.exe"
echo.
echo Install to: "%DEST%"
choice /C YN /M "Start installation"
if errorlevel 2 exit /b 0
taskkill /IM "Niclusive Studio 2.exe" /T /F >nul 2>&1
mkdir "%STAGE%" >nul 2>&1
if not exist "%STAGE%" (
  echo ERROR: Could not create temporary folder.
  pause
  exit /b 1
)
echo Extracting files...
powershell -NoProfile -ExecutionPolicy Bypass -Command "Expand-Archive -LiteralPath '%ZIP%' -DestinationPath '%STAGE%' -Force" >>"%LOG%" 2>&1
if errorlevel 1 (
  echo ERROR: Extraction failed. Target folder was not changed.
  rmdir /s /q "%STAGE%" >nul 2>&1
  echo Details: "%LOG%"
  pause
  exit /b 1
)
if exist "%STAGE%\Niclusive Studio\Niclusive Studio 2.exe" set "SOURCE=%STAGE%\Niclusive Studio"
if not defined SOURCE (
  echo ERROR: Program executable missing from extracted package.
  rmdir /s /q "%STAGE%" >nul 2>&1
  pause
  exit /b 1
)
if not exist "%SOURCE%\resources\app.asar" (
  echo ERROR: resources\app.asar missing. Installation cancelled.
  rmdir /s /q "%STAGE%" >nul 2>&1
  pause
  exit /b 1
)
set "BACKUP="
if exist "%DEST%" (
  for /f %%I in ('powershell -NoProfile -Command "Get-Date -Format yyyyMMdd-HHmmss"') do set "STAMP=%%I"
  set "BACKUP=%DEST%-backup-!STAMP!"
  echo Backing up existing installation to: "!BACKUP!"
  robocopy "%DEST%" "!BACKUP!" /E /COPY:DAT /DCOPY:DAT /R:1 /W:1 /XJ >>"%LOG%" 2>&1
  set "RC=!ERRORLEVEL!"
  if !RC! GEQ 8 (
    echo ERROR: Backup failed. Installation cancelled.
    rmdir /s /q "%STAGE%" >nul 2>&1
    echo Details: "%LOG%"
    pause
    exit /b 1
  )
)
if not exist "%DEST%" mkdir "%DEST%" >nul 2>&1
if not exist "%DEST%" (
  echo ERROR: Could not create target folder.
  rmdir /s /q "%STAGE%" >nul 2>&1
  pause
  exit /b 1
)
echo Installing program files...
robocopy "%SOURCE%" "%DEST%" /E /COPY:DAT /DCOPY:DAT /R:2 /W:1 /XJ >>"%LOG%" 2>&1
set "RC=%ERRORLEVEL%"
if %RC% GEQ 8 goto :INSTALL_FAILED
if not exist "%APP%" goto :INSTALL_FAILED
if not exist "%DEST%\resources\app.asar" goto :INSTALL_FAILED
set "SHORTCUT=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Niclusive Studio 2.lnk"
powershell -NoProfile -ExecutionPolicy Bypass -Command "$w=New-Object -ComObject WScript.Shell; $s=$w.CreateShortcut('%SHORTCUT%'); $s.TargetPath='%APP%'; $s.WorkingDirectory='%DEST%'; $s.Description='Niclusive Music Studio 2'; $s.Save()" >>"%LOG%" 2>&1
rmdir /s /q "%STAGE%" >nul 2>&1
echo.
echo ==========================================================
echo INSTALLATION COMPLETED
echo ==========================================================
echo Installed to: "%DEST%"
if defined BACKUP echo Previous installation backup: "!BACKUP!"
echo.
echo The installer checks package structure and main files, but cannot guarantee
echo that audio, MIDI and all features work on this PC. Please launch and test.
choice /C YN /M "Start Niclusive Studio 2 now"
if not errorlevel 2 start "" "%APP%"
exit /b 0
:INSTALL_FAILED
echo.
echo ERROR: Installation did not complete successfully.
echo Attempting to restore previous installation...
if defined BACKUP (
  if exist "%BACKUP%" (
    if not exist "%DEST%" mkdir "%DEST%" >nul 2>&1
    robocopy "%BACKUP%" "%DEST%" /E /COPY:DAT /DCOPY:DAT /R:2 /W:1 /XJ >>"%LOG%" 2>&1
    echo Backup retained: "%BACKUP%"
  )
)
rmdir /s /q "%STAGE%" >nul 2>&1
echo Details: "%LOG%"
pause
exit /b 1
