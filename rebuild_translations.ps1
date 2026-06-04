$orig = Get-Content 'docs\translations.original.js' -Raw -Encoding UTF8
$new_langs = Get-Content 'docs\new_langs.json' -Raw -Encoding UTF8

$splitStr = "// Language management - expose to window"
$splitIndex = $orig.IndexOf($splitStr)

$part1 = $orig.Substring(0, $splitIndex)
$part2 = $orig.Substring($splitIndex)

# Remove the closing '  },' or '  }' from the end of part1.
# Specifically, we know part1 ends with:
#   it: { ... }
# };\n\n
$part1 = $part1 -replace '(?m)^\};\r?\n\r?\n$', ''
$part1 = $part1 -replace '(?s)  it: \{\s*(.*?)\s*\}\s*$', "  it: {`n`$1`n  },"

$new_langs_trimmed = $new_langs -replace '^\s*\{\r?\n', ''
$new_langs_trimmed = $new_langs_trimmed -replace '\r?\n\}\s*$', ''

$combined = $part1 + "`n" + $new_langs_trimmed + "`n};`n`n" + $part2

Set-Content 'docs\translations.js' -Value $combined -Encoding UTF8
