#define MyAppName "BSymphonic"
#define MyAppExeName "BSymphonic.exe"
#define MyAppDirName "BSymphonic"
#define MyAppVersion "1.0"
#define MyAppPublisher "JSymphonic"
#define MyAppURL "https://github.com"
#define MySourceDir "..\\build\\windows-portable\\BSymphonic"
#define MyIconFile "..\\build-resources\\windows\\app-icon.ico"

[Setup]
AppId={{D2A5957E-2C01-4BD0-96C7-8A821A0D0F3A}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={autopf}\{#MyAppDirName}
DefaultGroupName={#MyAppName}
AllowNoIcons=yes
DisableProgramGroupPage=yes
LicenseFile=..\LICENSE
InfoBeforeFile=..\scripts\installer-info-vi.txt
OutputDir=..\build\windows-installer
OutputBaseFilename=BinhTagilla-JSymphonic-Setup
Compression=lzma
SolidCompression=yes
WizardStyle=modern
PrivilegesRequired=lowest
PrivilegesRequiredOverridesAllowed=dialog
ArchitecturesInstallIn64BitMode=x64compatible
SetupIconFile={#MyIconFile}
UninstallDisplayIcon={app}\{#MyAppExeName}
WizardResizable=no

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "Tao icon tren desktop"; GroupDescription: "Tuy chon them:"

[Files]
Source: "{#MySourceDir}\*"; DestDir: "{app}"; Flags: recursesubdirs ignoreversion

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; IconFilename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon; IconFilename: "{app}\{#MyAppExeName}"

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "Mở {#MyAppName} ngay"; Flags: nowait postinstall skipifsilent

[CustomMessages]
english.WelcomeLabel1=Trình cài đặt sẽ hướng dẫn bạn cài BSymphonic vào máy tính.
english.WelcomeLabel2=Bạn có thể chọn thư mục cài đặt, tạo biểu tượng ngoài màn hình chính và mở ứng dụng ngay sau khi cài xong.
english.SelectDirLabel3=Chọn thư mục muốn cài ứng dụng rồi bấm Tiếp tục.
english.SelectDirBrowseLabel=Thư mục cài đặt:
english.ReadyLabel1=Trình cài đặt đã sẵn sàng để chép ứng dụng vào máy.
english.FinishedHeadingLabel=Đã cài đặt xong BSymphonic
english.FinishedLabel=Ứng dụng đã được cài xong trên máy này.
