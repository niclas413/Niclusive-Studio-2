; Niclusive Music Studio 2 — Inno Setup installer
; Compile on Windows with Inno Setup. Expected layout: this .iss file next to "Niclusive Studio".

#define MyAppName "Niclusive Music Studio 2"
#define MyAppVersion "2.0.0"
#define MyAppPublisher "Niclusive"
#define MyAppExeName "Niclusive Studio 2.exe"

[Setup]
AppId={{A7A8B8B2-58D1-4E4A-9F31-0D9E29C2A201}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
DefaultDirName={localappdata}\Programs\Niclusive Studio 2
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=yes
PrivilegesRequired=lowest
OutputDir=output
OutputBaseFilename=Niclusive-Studio-2-Setup
Compression=lzma2/max
SolidCompression=yes
WizardStyle=modern
ArchitecturesInstallIn64BitMode=x64
UninstallDisplayIcon={app}\{#MyAppExeName}
CloseApplications=yes
RestartApplications=no
SetupLogging=yes

[Languages]
Name: "german"; MessagesFile: "compiler:Languages\German.isl"
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "Desktop-Verknüpfung erstellen"; GroupDescription: "Zusätzliche Aufgaben:"; Flags: unchecked

[Files]
Source: "Niclusive Studio\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{autoprograms}\Niclusive Music Studio 2"; Filename: "{app}\{#MyAppExeName}"; WorkingDir: "{app}"
Name: "{autodesktop}\Niclusive Music Studio 2"; Filename: "{app}\{#MyAppExeName}"; WorkingDir: "{app}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "Niclusive Music Studio 2 starten"; Flags: postinstall nowait skipifsilent