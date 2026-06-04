$content = Get-Content 'docs\translations.js' -Raw -Encoding UTF8

$translations = @{
    'fr' = @{ 'collaborators' = 'Collaborateurs'; 'collaboratorsSubtitle' = 'Rencontrez notre équipe et nos contributeurs.'; 'graphicDesigner' = 'Graphiste'; 'graphicDesignDesc' = ' - Création Graphique & Design' }
    'en' = @{ 'collaborators' = 'Collaborators'; 'collaboratorsSubtitle' = 'Meet our team and contributors.'; 'graphicDesigner' = 'Graphic Designer'; 'graphicDesignDesc' = ' - Graphic Creation & Design' }
    'ja' = @{ 'collaborators' = '44Kz44Op44Oc44Os44O844K/44O8'; 'collaboratorsSubtitle' = '56eB44Gf44Gh44Gu44OB44O844Og44Go6LKi54yu6ICF44Gr5Lya44GE44G+44GX44KH44GG44CC'; 'graphicDesigner' = '44Kw44Op44OV44Kj44OD44Kv44OH44K244Kk44OK44O8'; 'graphicDesignDesc' = 'IC0g44Kw44Op44OV44Kj44OD44Kv5L2c5oiQ44Go44OH44K244Kk44Oz' }
    'zh' = @{ 'collaborators' = '5ZCI5L2c6ICF'; 'collaboratorsSubtitle' = '6K6k6K+G5oiR5Lus55qE5Zui6Zif5ZKM6LSh54yu6ICF44CC'; 'graphicDesigner' = '5bmz6Z2i6K6+6K6h5biI'; 'graphicDesignDesc' = 'IC0g5Zu+5b2i5Yib5L2c5LiO6K6+6K6h' }
    'ko' = @{ 'collaborators' = '6rO164+ZIOyekeyXheyekA=='; 'collaboratorsSubtitle' = '7Jqw66asIO2MgOqzvCDquLDrh6zEnoDrk6TsnEwg66eM64KY67O07IS47JqULg=='; 'graphicDesigner' = '6re4656Y7Z29IOuUlOyekOydtOuPhA=='; 'graphicDesignDesc' = 'IC0g6re4656Y7Z29IOKCcOyekQ==' }
    'es' = @{ 'collaborators' = 'Colaboradores'; 'collaboratorsSubtitle' = 'Conoce a nuestro equipo y colaboradores.'; 'graphicDesigner' = 'Diseñador Gráfico'; 'graphicDesignDesc' = ' - Creación Gráfica y Diseño' }
    'de' = @{ 'collaborators' = 'Mitarbeiter'; 'collaboratorsSubtitle' = 'Lernen Sie unser Team und unsere Mitwirkenden kennen.'; 'graphicDesigner' = 'Grafikdesigner'; 'graphicDesignDesc' = ' - Grafische Gestaltung & Design' }
}

$utf8 = [System.Text.Encoding]::UTF8

foreach ($lang in $translations.Keys) {
    $trans = $translations[$lang]
    
    $c = $trans['collaborators']
    $s = $trans['collaboratorsSubtitle']
    $g = $trans['graphicDesigner']
    $d = $trans['graphicDesignDesc']

    if ($lang -in @('ja', 'zh', 'ko')) {
        $c = $utf8.GetString([Convert]::FromBase64String($c))
        $s = $utf8.GetString([Convert]::FromBase64String($s))
        $g = $utf8.GetString([Convert]::FromBase64String($g))
        $d = $utf8.GetString([Convert]::FromBase64String($d))
    }

    $pattern = '(?s)(^\s*' + $lang + ':\s*\{)(.*?)(^\s*\},?)'
    $match = [regex]::Match($content, $pattern, [System.Text.RegularExpressions.RegexOptions]::Multiline)

    if ($match.Success) {
        $block = $match.Groups[2].Value
        $block = $block -replace '(?m)^\s*"collaborators":\s*".*?",?\r?\n', ''
        $block = $block -replace '(?m)^\s*"collaboratorsSubtitle":\s*".*?",?\r?\n', ''
        $block = $block -replace '(?m)^\s*"graphicDesigner":\s*".*?",?\r?\n', ''
        $block = $block -replace '(?m)^\s*"graphicDesignDesc":\s*".*?",?\r?\n', ''
        
        $additions = "`n    `"collaborators`": `"$c`",`n    `"collaboratorsSubtitle`": `"$s`",`n    `"graphicDesigner`": `"$g`",`n    `"graphicDesignDesc`": `"$d`",`n"
        
        $newBlock = $additions + $block
        $content = $content.Substring(0, $match.Groups[1].Index) + $match.Groups[1].Value + $newBlock + $content.Substring($match.Groups[3].Index)
    }
}

Set-Content 'docs\translations.js' -Value $content -Encoding UTF8
