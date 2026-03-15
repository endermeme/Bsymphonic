$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $PSScriptRoot
Set-Location $root

Write-Host "[1/3] Build jar va wrapper..."
$env:MAVEN_OPTS = "--add-opens java.base/java.util=ALL-UNNAMED --add-opens java.base/java.lang.reflect=ALL-UNNAMED --add-opens java.base/java.text=ALL-UNNAMED --add-opens java.desktop/java.awt.font=ALL-UNNAMED"
mvn -B -DskipTests verify

$fatJar = Join-Path $root "target\jsymphonic-0.5.3-jar-with-dependencies.jar"
if (-not (Test-Path $fatJar)) {
    throw "Khong tim thay fat jar: $fatJar"
}

$workDir = Join-Path $root "build\windows-installer"
$inputDir = Join-Path $workDir "input"
$distDir = Join-Path $workDir "dist"

if (Test-Path $workDir) {
    Remove-Item -Recurse -Force $workDir
}

New-Item -ItemType Directory -Force -Path $inputDir | Out-Null
New-Item -ItemType Directory -Force -Path $distDir | Out-Null
Copy-Item $fatJar (Join-Path $inputDir "jsymphonic.jar")

Write-Host "[2/3] Tao installer exe bang jpackage..."
jpackage `
  --type exe `
  --name "BinhTagilla-JSymphonic" `
  --dest $distDir `
  --input $inputDir `
  --main-jar "jsymphonic.jar" `
  --main-class "org.danizmax.jsymphonic.gui.JSymphonic" `
  --vendor "Binh Tagilla" `
  --description "Binh Tagilla JSymphonic Revival" `
  --win-shortcut `
  --win-menu `
  --java-options "-Dfile.encoding=UTF-8"

$installer = Get-ChildItem $distDir -Filter *.exe | Select-Object -First 1
if (-not $installer) {
    throw "Khong tao duoc installer exe."
}

Write-Host "[3/3] Hoan tat"
Write-Host $installer.FullName
