[CmdletBinding()]
param([switch]$VerifyOnly)
$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'
if ($env:OS -ne 'Windows_NT') { throw 'This installer must run on the intended Windows PC.' }
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$releaseBase = 'https://github.com/sunghwanki92/tomki-claude-work-collector/releases/latest/download'
$setupDir = Join-Path $env:LOCALAPPDATA ('TomKiClaudeCollector\setup\' + [Guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $setupDir -Force | Out-Null
$binaryPath = Join-Path $setupDir 'TomKiClaudeCollector.exe'
$checksumPath = Join-Path $setupDir 'SHA256SUMS.txt'
Invoke-WebRequest -UseBasicParsing -Uri ($releaseBase + '/TomKiClaudeCollector.exe') -OutFile $binaryPath -TimeoutSec 45
Invoke-WebRequest -UseBasicParsing -Uri ($releaseBase + '/SHA256SUMS.txt') -OutFile $checksumPath -TimeoutSec 45
$checksumLine = @(Get-Content $checksumPath | Where-Object { $_ -match '^([a-fA-F0-9]{64})\s+\*?TomKiClaudeCollector\.exe$' })
if ($checksumLine.Count -ne 1) { throw 'Missing or ambiguous release checksum.' }
$expectedHash = ($checksumLine[0] -split '\s+')[0].ToLowerInvariant()
$actualHash = (Get-FileHash -Algorithm SHA256 -Path $binaryPath).Hash.ToLowerInvariant()
if ($actualHash -ne $expectedHash) { throw 'Checksum mismatch. The downloaded program will not run.' }
Write-Output 'Release SHA-256 verified.'
if ($VerifyOnly) { Write-Output 'Verification only: installer was not launched.'; return }
Start-Process -FilePath $binaryPath
Write-Output 'Installer opened. Complete Google login and the PC connection approval in your browser.'
