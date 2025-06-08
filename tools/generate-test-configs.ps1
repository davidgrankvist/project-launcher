$basePath = (Get-Location).Path

Get-ChildItem -Recurse -File .\test\projects | `
    ForEach-Object { "." + $_.FullName.SubString($basePath.Length)  } | `
    Where-Object { $_.EndsWith(".bat") -or $_.EndsWith(".ps1") } `
    > .\test\settingsWindows.txt

Get-ChildItem -Recurse -File .\test\projects | `
    ForEach-Object { "." + $_.FullName.SubString($basePath.Length)  } | `
    Where-Object { -not ($_.EndsWith(".bat") -or $_.EndsWith(".ps1")) } | `
    ForEach-Object { $_.Replace("\", "/") } `
    > .\test\settingsUnix.txt
