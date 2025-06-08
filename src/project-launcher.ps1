$settings = "$HOME\.project-launcher\settings.txt"

if ($args.Count -ge 2 -and $args[0] -eq "--settings") {
    $settings = $args[1]
}

if (-not (Test-Path $settings)) {
    Write-Host "Unable to load settings. File not found: $settings"
    Write-Host "To solve this, add a global setting or use the --settings option."
    exit 1
}

$content = Get-Content $settings
$filteredContent = $content
$filter = ""
$selected = 0

function PositiveMod($a, $b) {
    return (($a % $b) + $b) % $b
}

# live grep and launch selection
while ($true) {
    Clear-Host
    if ($filter -eq "") {
        $filteredContent = $content
    } else {
        $filteredContent = $content | `
            Where-Object { $_.Contains($filter) }
    }

    if ($filteredContent.Count -gt 0) {
        $selected = $selected % $filteredContent.Count
    }

    for ($i = 0; $i -lt $filteredContent.Count; $i = $i + 1) {
        $item = $filteredContent[$i]
        if ($filteredContent.Count -eq 1) {
            $item = $filteredContent
        }

        if ($i -eq $selected) {
            Write-host "$item <-- selected"
        } else {
            Write-host $item
        }
    }

    Write-Host "> $filter" -NoNewLine
    $inputKey = [System.Console]::ReadKey($true)
    if ($inputKey.Key -eq "Escape") {
        break;
    } elseif ($inputKey.Key -eq "Enter" -and $filteredContent.Count -gt 0) {
        $result = $filteredContent[$selected]
        if ($filteredContent.Count -eq 1) {
            $result = $filteredContent
        }
        Clear-Host
        & $result
        break
    } elseif ($inputKey.Key -eq "UpArrow") {
        $selected = PositiveMod ($selected - 1) $filteredContent.Count
    } elseif ($inputKey.Key -eq "DownArrow") {
        $selected = ($selected + 1) % $filteredContent.Count
    } elseif (-not ($filter -eq "") -and $inputKey.Key -eq "Backspace") {
        $filter = $filter.SubString(0, $filter.Length - 1)
    } else {
        $filter = $filter + $inputKey.KeyChar
    }
}
