# PowerShell HexDump Caesar Cipher

This PowerShell script performs a Caesar cipher encryption on the hex dump of a given file. 
It supports shifting letters (A-Z, a-z) and digits (0-9), while leaving punctuation and symbols unchanged.

## How It Works
1. Prompts the user to enter a file path.
2. Validates the existence of the file.
3. Dumps the file content in hexadecimal format using Format-Hex.
4. Applies a Caesar cipher shift (default: 3) to all alphabetic and numeric characters.
5. Outputs the encrypted result to the console.

## encryption script
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
           33 34 35 36 37 38 39 30 31 32 3D 3E 3F 3G 3H 3I


Write-Host $encrypted
```
## Sample input 
```
           00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F

00000000   54 68 69 73 20 69 73 20 73 6F 6D 65 20 63 6F 6E  This is some con
00000010   74 65 6E 74 20 74 6F 20 66 69 6C 6C 20 74 68 65  tent to fill the
00000020   20 74 65 78 74 20 66 69 6C 65 0A                  text file.
```

## Sample output (shift = 3)

```
           33 34 35 36 37 38 39 30 31 32 3D 3E 3F 3G 3H 3I

33333333   87 91 92 06 53 92 06 53 06 9I 9G 98 53 96 9I 9H  WQRB RB BXVN LXW
33333343   07 98 9H 07 53 07 9I 53 99 92 9F 9F 53 07 91 98  CNWC CX ORUU CQN
33333353   53 07 98 01 07 53 99 92 9F 98 3D                  CNGC ORUN.
```
