$content = Get-Content 'translations.js' -Raw -Encoding UTF8
$enRegex = [regex]'(?s)en:\s*\{([^}]+)\}'
$match = $enRegex.Match($content)
$enContent = $match.Groups[1].Value
$langs = @('pt', 'ru', 'ar', 'hi', 'tr', 'nl', 'pl', 'vi')
$appendStr = ""
foreach ($lang in $langs) {
    $appendStr += "`n  " + $lang + ": {" + $enContent + "},"
}
$content = $content -replace '\s*};\s*$', "`n$appendStr`n};`n"
Set-Content 'translations.js' -Value $content -Encoding UTF8
Write-Host 'Done'
