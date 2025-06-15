$file = Read-Host "Enter file"

if (Test-Path $file) {
    $hexDump = (Format-Hex -Path $file | Out-String)
} else {
    Write-Host "Not found"
    exit
}

function Caesar-Cipher {
    param(
        [string]$Text,
        [int]$Shift
    )

    $output = ""

    foreach ($char in $Text.ToCharArray()) {
        if ($char -match '[A-Z]') {
            $base = [int][char]'A'
            $shifted = (([int][char]$char - $base + $Shift) % 26) + $base
            $output += [char]$shifted
        }
        elseif ($char -match '[a-z]') {
            $base = [int][char]'a'
            $shifted = (([int][char]$char - $base + $Shift) % 26) + $base
            $output += [char]$shifted
        }
        elseif ($char -match '[0-9]') {
            $base = [int][char]'0'
            $shifted = (([int][char]$char - $base + $Shift) % 10) + $base
            $output += [char]$shifted
        }
        else {
            $output += $char
        }
    }

    return $output
}

$shift = 3
$encrypted = Caesar-Cipher -Text $hexDump -Shift $shift

Write-Host $encrypted
