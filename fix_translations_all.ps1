$content = Get-Content 'docs\translations.js' -Raw -Encoding UTF8

$translations = @{
    'fr' = @{ 'collaborators' = 'Q29sbGFib3JhdGV1cnM='; 'collaboratorsSubtitle' = 'UmVuY29udHJleiBub3RyZSDDqXF1aXBlIGV0IG5vcyBjb250cmlidXRldXJzLg=='; 'graphicDesigner' = 'R3JhcGhpc3Rl'; 'graphicDesignDesc' = 'IC0gQ3LDqWF0aW9uIEdyYXBoaXF1ZSAmIERlc2lnbg==' }
    'en' = @{ 'collaborators' = 'Q29sbGFib3JhdG9ycw=='; 'collaboratorsSubtitle' = 'TWVldCBvdXIgdGVhbSBhbmQgY29udHJpYnV0b3JzLg=='; 'graphicDesigner' = 'R3JhcGhpYyBEZXNpZ25lcg=='; 'graphicDesignDesc' = 'IC0gR3JhcGhpYyBDcmVhdGlvbiAmIERlc2lnbg==' }
    'ja' = @{ 'collaborators' = '44Kz44Op44Oc44Os44O844K/44O8'; 'collaboratorsSubtitle' = '56eB44Gf44Gh44Gu44OB44O844Og44Go6LKi54yu6ICF44Gr5Lya44GE44G+44GX44KH44GG44CC'; 'graphicDesigner' = '44Kw44Op44OV44Kj44OD44Kv44OH44K244Kk44OK44O8'; 'graphicDesignDesc' = 'IC0g44Kw44Op44OV44Kj44OD44Kv5L2c5oiQ44Go44OH44K244Kk44Oz' }
    'zh' = @{ 'collaborators' = '5ZCI5L2c6ICF'; 'collaboratorsSubtitle' = '6K6k6K+G5oiR5Lus55qE5Zui6Zif5ZKM6LSh54yu6ICF44CC'; 'graphicDesigner' = '5bmz6Z2i6K6+6K6h5biI'; 'graphicDesignDesc' = 'IC0g5Zu+5b2i5Yib5L2c5LiO6K6+6K6h' }
    'ko' = @{ 'collaborators' = '6rO164+ZIOyekeyXheyekA=='; 'collaboratorsSubtitle' = '7Jqw66asIO2MgOqzvCDquLDrh6zEnoDrk6TsnEwg66eM64KY67O07IS47JqULg=='; 'graphicDesigner' = '6re4656Y7Z29IOuUlOyekOydtOuPhA=='; 'graphicDesignDesc' = 'IC0g6re4656Y7Z29IOKCcOyekQ==' }
    'es' = @{ 'collaborators' = 'Q29sYWJvcmFkb3Jlcw=='; 'collaboratorsSubtitle' = 'Q29ub2NlIGEgbnVlc3RybyBlcXVpcG8geSBjb2xhYm9yYWRvcmVzLg=='; 'graphicDesigner' = 'RGlzZcOxYWRvciBHcsOhZmljbw=='; 'graphicDesignDesc' = 'IC0gQ3JlYWNpw7NuIEdyw6FmaWNhIHkgRGlzZcOxbw==' }
    'de' = @{ 'collaborators' = 'TWl0YXJiZWl0ZXI='; 'collaboratorsSubtitle' = 'TGVybmVuIFNpZSB1bnNlciBUZWFtIHVuZCB1bnNlcmUgTWl0d2lya2VuZGVuIGtlbm5lbi4='; 'graphicDesigner' = 'R3JhZmlrZGVzaWduZXI='; 'graphicDesignDesc' = 'IC0gR3JhZmlzY2hlIEdlc3RhbHR1bmcgJiBEZXNpZ24=' }
    'it' = @{ 'collaborators' = 'Q29sbGFib3JhdG9yaQ=='; 'collaboratorsSubtitle' = 'SW5jb250cmEgaWwgbm9zdHJvIHRlYW0gZSBpIGNvbGxhYm9yYXRvcmku'; 'graphicDesigner' = 'R3JhZmljbw=='; 'graphicDesignDesc' = 'IC0gQ3JlYXppb25lIEdyYWZpY2EgZSBEZXNpZ24=' }
    'pt' = @{ 'collaborators' = 'Q29sYWJvcmFkb3Jlcw=='; 'collaboratorsSubtitle' = 'Q29uaGXDp2Egbm9zc2EgZXF1aXBlIGUgY29sYWJvcmFkb3Jlcy4='; 'graphicDesigner' = 'RGVzaWduZXIgR3LDoWZpY28='; 'graphicDesignDesc' = 'IC0gQ3JpYcOnw6NvIEdyw6FmaWNhIGUgRGVzaWdu' }
    'ru' = @{ 'collaborators' = '0KHQvtGC0YDRg9C00L3QuNC60Lg='; 'collaboratorsSubtitle' = '0J/QvtC30L3QsNC60L7QvNGM0YLQtdGB0Ywg0YEg0L3QsNGI0LXQuSDQutC+0LzQsNC90LTQvtC5INC4INGD0YfQsNGB0YLQvdC40LrQsNC80Lgu'; 'graphicDesigner' = '0JPRgNCw0YTQuNGH0LXRgdC60LjQuSDQtNC40LfQsNC50L3QtdGA'; 'graphicDesignDesc' = 'IC0g0JPRgNCw0YTQuNGH0LXRgdC60L7QtSDRgdC+0LfQtNCw0L3QuNC1INC4INC00LjQt9Cw0LnQvQ==' }
    'ar' = @{ 'collaborators' = '2KfZhNmF2KrYudin2YjZhtmI2YY='; 'collaboratorsSubtitle' = '2KrYudix2YEg2LnZhNmJIMmB2LHZitmC2YbYpyDZiNin2YTZhdi02KfZhNmK2YYu'; 'graphicDesigner' = '2YXYtdmF2YUg2KzYsdin2YHitmM='; 'graphicDesignDesc' = 'IC0g2KfZhNil2KjYrdiv2KfYuSDYp9mE2KzYsdin2YHitmM=' }
    'hi' = @{ 'collaborators' = '4oCz4oCo4oCA4oCq4oC04oC44oC04oCc4oCA4oCS4oCo4oCk4oC04oCd4oC04oCo4oC44oCA4oCQ4oCA4oCc'; 'collaboratorsSubtitle' = '4oC44oCk4oCA4oC54oCQ4oC04oCU4oCw4oCA4oCU4oCk4oCo4oCc4oC04oCt4oCU4oCg4oCU4oCs4oCE4oCA4oCo4oCc4oCl4oCA4oCc4oCo4oCQ4oCU4oCc4oCs4oCU4oCo4oCC4oC44oCE4oCA4oC44oCg4oCo4oCU4oC44oCA4oCc4oCo4oCk4oCg4oCU4oCc4oCA4oCC'; 'graphicDesigner' = '4oCz4oCo4oCA4oCq4oC04oC44oC04oCc4oCA4oCS4oCo4oCk4oC04oCd4oC04oCo4oC44oCA4oCQ4oCA4oCc'; 'graphicDesignDesc' = 'IC0g4oCz4oCo4oCA4oCq4oC04oC44oC04oCc4oCA4oCo4oCk4oC44oC04oCA4oCA4oCQ4oCc4oCo4oCA4oCk4oCA4oCc4oCA4oCS4oCo4oCk4oC04oCd4oC04oCo4oCc' }
    'tr' = @{ 'collaborators' = 'w4dhbMSxxZ9hbmxhcg=='; 'collaboratorsSubtitle' = 'RWtpYmltaXogdmUga2F0a8SxZGEgYnVsdW5hbmxhcmxhIHRhbsSxxZ/EsW4u'; 'graphicDesigner' = 'R3JhZmlrIFRhc2FyxLFtY8Sx'; 'graphicDesignDesc' = 'IC0gR3JhZmlrIE9sdcWfdHVybWEgdmUgVGFzYXLEsW0=' }
    'nl' = @{ 'collaborators' = 'TWVkZXdlcmtlcnM='; 'collaboratorsSubtitle' = 'T250bW9ldCBvbnMgdGVhbSBlbiBvbnplIG1lZGV3ZXJrZXJzLg=='; 'graphicDesigner' = 'R3JhZmlzY2ggT250d2VycGVy'; 'graphicDesignDesc' = 'IC0gR3JhZmlzY2hlIENyZWF0aWUgJiBPbnR3ZXJw' }
    'pl' = @{ 'collaborators' = 'V3Nww7PFgnByYWNvd25pY3k='; 'collaboratorsSubtitle' = 'UG96bmFqIG5hc3ogenBlc3DDs8WCPWknd3Nww7PFgnByYWNvd25pa8Ozdy4='; 'graphicDesigner' = 'UHJvamVrdGFudCBncmFmaWN6bnk='; 'graphicDesignDesc' = 'IC0gVHdvcnplbmllIGdyYWZpa2kgaSBwcm9qZWt0b3dhbmll' }
    'vi' = @{ 'collaborators' = 'Q+G7mW5nIHTDoWMgdmnDqm4='; 'collaboratorsSubtitle' = 'R+G6t3AgZ+G7oSDEkeG7mWkgbmfFqSB2w6Agbmjhu69uZyBuZ8aw4budaSDEkcOzbmcgZ8OzcCBj4bunYSBjaMO6bmcgdMO0aS4='; 'graphicDesigner' = 'VGhp4bq/dCBr4bq/IMSR4buTIGjhu41h'; 'graphicDesignDesc' = 'IC0gU8OhbmcgdOG6oW8gxJDhu5MgaOG7jWEgJiBUaGnhur90IGvhur8=' }
}

$utf8 = [System.Text.Encoding]::UTF8

foreach ($lang in $translations.Keys) {
    $trans = $translations[$lang]
    
    $c = $utf8.GetString([Convert]::FromBase64String($trans['collaborators']))
    $s = $utf8.GetString([Convert]::FromBase64String($trans['collaboratorsSubtitle']))
    $g = $utf8.GetString([Convert]::FromBase64String($trans['graphicDesigner']))
    $d = $utf8.GetString([Convert]::FromBase64String($trans['graphicDesignDesc']))

    $pattern = '(?s)(^\s*"?' + $lang + '"?:\s*\{)(.*?)(^\s*\},?)'
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
