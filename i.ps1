$extDir = "$env:USERPROFILE\.vscode\extensions\cstar-cmp-0.0.1"
New-Item -ItemType Directory -Path $extDir -Force | Out-Null
New-Item -ItemType Directory -Path (Join-Path $extDir "syntaxes") -Force | Out-Null

# copy your files (adjust paths if needed)
Copy-Item "D:\CStar\syntaxes\cmp.tmLanguage.json" (Join-Path $extDir "syntaxes\cstar-cmp.tmLanguage.json") -Force
Copy-Item "D:\CStar\syntaxes\package.json" (Join-Path $extDir "package.json") -Force

# restart VS Code after copying
Write-Host "Files copied. Restart VS Code to load the new local extension."