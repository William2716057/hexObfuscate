# PowerShell HexDump Caesar Cipher

This PowerShell script performs a Caesar cipher encryption on the hex dump of a given file. 
It supports shifting letters (A-Z, a-z) and digits (0-9), while leaving punctuation and symbols unchanged.

## How It Works
1. Prompts the user to enter a file path.
2. Validates the existence of the file.
3. Dumps the file content in hexadecimal format using Format-Hex.
4. Applies a Caesar cipher shift (default: 3) to all alphabetic and numeric characters.
5. Outputs the encrypted result to the console.

