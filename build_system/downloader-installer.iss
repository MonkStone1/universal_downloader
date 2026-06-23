; Inno Setup script for Video Downloader installer

[Setup]
AppName=Video Downloader
AppVersion=1.0
DefaultDirName={commonpf}\Video Downloader
DefaultGroupName=Video Downloader
OutputDir=installer
OutputBaseFilename=VideoDownloader-Setup
Compression=lzma
SolidCompression=yes
PrivilegesRequired=admin
WizardStyle=modern
ShowLanguageDialog=yes
SetupIconFile=icon.ico

[Files]
Source: "downloader.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "ffmpeg.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "ffprobe.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "vlc-3.0.23-win64.exe"; DestDir: "{tmp}"; Flags: deleteafterinstall ignoreversion
Source: "icon.ico"; DestDir: "{app}"; Flags: ignoreversion

[Tasks]
Name: "installvlc"; Description: "Install VLC Media Player (recommended for HEVC playback)"; GroupDescription: "Additional components:"; Flags: unchecked
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"

[Run]
Filename: "{tmp}\vlc-3.0.23-win64.exe"; Parameters: "/S"; Tasks: installvlc; Flags: runhidden postinstall skipifsilent waituntilterminated

[Icons]
Name: "{group}\Video Downloader"; Filename: "{app}\downloader.exe"; IconFilename: "{app}\icon.ico"
Name: "{group}\{cm:UninstallProgram,Video Downloader}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\Video Downloader"; Filename: "{app}\downloader.exe"; Tasks: desktopicon; IconFilename: "{app}\icon.ico"; Comment: "Download videos from popular sites"

[Languages]
Name: "russian"; MessagesFile: "compiler:Languages\Russian.isl"
Name: "english"; MessagesFile: "D:\Soft\Inno Setup 6\Default.isl"
