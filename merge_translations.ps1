$orig = Get-Content 'docs\translations.original.js' -Raw -Encoding UTF8
$new_langs = Get-Content 'docs\new_langs.json' -Raw -Encoding UTF8

# Remove the closing `};` from orig
$orig = $orig -replace '\r?\n\};\r?\n\r?\n// Language management', ','

# Remove the opening `{` and closing `}` from new_langs
$new_langs = $new_langs -replace '^\s*\{\r?\n', ''
$new_langs = $new_langs -replace '\r?\n\}\s*$', ''

# Combine
$combined = $orig + "`n" + $new_langs + "`n};`n`n// Language management"

# The rest of translations.original.js has the language management code
$tail = $orig_raw_from_github # wait I need the tail.

# Let's just do it cleanly
