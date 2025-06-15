# PowerShell HexDump Caesar Cipher

This PowerShell script performs a Caesar cipher encryption on the hex dump of a given file. 
It supports shifting letters (A-Z, a-z) and digits (0-9), while leaving punctuation and symbols unchanged.

## How It Works
1. Prompts the user to enter a file path.
2. Validates the existence of the file.
3. Dumps the file content in hexadecimal format using Format-Hex.
4. Applies a Caesar cipher shift (default: 3) to all alphabetic and numeric characters.
5. Outputs the encrypted result to the console.

```
$file = Read-Host "Enter file"

if (Test-Path $file) {
    $hexDump = (Format-Hex -Path $file | Where-Object { $_ -notmatch '^Path\s+:\s' }) -join "`n"
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
```
