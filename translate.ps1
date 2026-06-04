$content = Get-Content 'docs\translations.js' -Raw -Encoding UTF8

$translations = @{
    'fr' = @{ 'collaborators' = 'Collaborateurs'; 'collaboratorsSubtitle' = 'Rencontrez notre équipe et nos contributeurs.'; 'graphicDesigner' = 'Graphiste'; 'graphicDesignDesc' = ' - Création Graphique & Design' }
    'en' = @{ 'collaborators' = 'Collaborators'; 'collaboratorsSubtitle' = 'Meet our team and contributors.'; 'graphicDesigner' = 'Graphic Designer'; 'graphicDesignDesc' = ' - Graphic Creation & Design' }
    'es' = @{ 'collaborators' = 'Colaboradores'; 'collaboratorsSubtitle' = 'Conoce a nuestro equipo y colaboradores.'; 'graphicDesigner' = 'Diseñador Gráfico'; 'graphicDesignDesc' = ' - Creación Gráfica y Diseño' }
    'de' = @{ 'collaborators' = 'Mitarbeiter'; 'collaboratorsSubtitle' = 'Lernen Sie unser Team und unsere Mitwirkenden kennen.'; 'graphicDesigner' = 'Grafikdesigner'; 'graphicDesignDesc' = ' - Grafische Gestaltung & Design' }
    'zh' = @{ 'collaborators' = '合作者'; 'collaboratorsSubtitle' = '认识我们的团队和贡献者。'; 'graphicDesigner' = '平面设计师'; 'graphicDesignDesc' = ' - 图形创作与设计' }
    'ja' = @{ 'collaborators' = 'コラボレーター'; 'collaboratorsSubtitle' = '私たちのチームと貢献者に会いましょう。'; 'graphicDesigner' = 'グラフィックデザイナー'; 'graphicDesignDesc' = ' - グラフィック作成とデザイン' }
    'ko' = @{ 'collaborators' = '공동 작업자'; 'collaboratorsSubtitle' = '우리 팀과 기여자들을 만나보세요.'; 'graphicDesigner' = '그래픽 디자이너'; 'graphicDesignDesc' = ' - 그래픽 제작 및 디자인' }
    'it' = @{ 'collaborators' = 'Collaboratori'; 'collaboratorsSubtitle' = 'Incontra il nostro team e i collaboratori.'; 'graphicDesigner' = 'Grafico'; 'graphicDesignDesc' = ' - Creazione Grafica e Design' }
    'pt' = @{ 'collaborators' = 'Colaboradores'; 'collaboratorsSubtitle' = 'Conheça nossa equipe e colaboradores.'; 'graphicDesigner' = 'Designer Gráfico'; 'graphicDesignDesc' = ' - Criação Gráfica e Design' }
    'ru' = @{ 'collaborators' = 'Сотрудники'; 'collaboratorsSubtitle' = 'Познакомьтесь с нашей командой и участниками.'; 'graphicDesigner' = 'Графический дизайнер'; 'graphicDesignDesc' = ' - Графическое создание и дизайн' }
    'ar' = @{ 'collaborators' = 'المتعاونون'; 'collaboratorsSubtitle' = 'تعرف على فريقنا والمساهمين.'; 'graphicDesigner' = 'مصمم جرافيك'; 'graphicDesignDesc' = ' - الإبداع الجرافيكي والتصميم' }
    'hi' = @{ 'collaborators' = 'सहयोगी'; 'collaboratorsSubtitle' = 'हमारी टीम और योगदानकर्ताओं से मिलें।'; 'graphicDesigner' = 'ग्राफिक डिज़ाइनर'; 'graphicDesignDesc' = ' - ग्राफिक निर्माण और डिजाइन' }
    'tr' = @{ 'collaborators' = 'Çalışanlar'; 'collaboratorsSubtitle' = 'Ekibimiz ve katkıda bulunanlarla tanışın.'; 'graphicDesigner' = 'Grafik Tasarımcı'; 'graphicDesignDesc' = ' - Grafik Oluşturma ve Tasarım' }
    'nl' = @{ 'collaborators' = 'Medewerkers'; 'collaboratorsSubtitle' = 'Ontmoet ons team en onze medewerkers.'; 'graphicDesigner' = 'Grafisch Ontwerper'; 'graphicDesignDesc' = ' - Grafische Creatie & Ontwerp' }
    'pl' = @{ 'collaborators' = 'Współpracownicy'; 'collaboratorsSubtitle' = 'Poznaj nasz zespół i współpracowników.'; 'graphicDesigner' = 'Projektant graficzny'; 'graphicDesignDesc' = ' - Tworzenie grafiki i projektowanie' }
    'vi' = @{ 'collaborators' = 'Cộng tác viên'; 'collaboratorsSubtitle' = 'Gặp gỡ đội ngũ và những người đóng góp của chúng tôi.'; 'graphicDesigner' = 'Thiết kế đồ họa'; 'graphicDesignDesc' = ' - Sáng tạo Đồ họa & Thiết kế' }
}

# Remove existing translation keys I appended earlier to avoid duplication
$content = $content -replace '(?m)^\s*"(?:collaborators|collaboratorsSubtitle|graphicDesigner|graphicDesignDesc)":\s*".*?",?\r?\n', ''

foreach ($lang in $translations.Keys) {
    $trans = $translations[$lang]
    $additions = "`n    `"collaborators`": `"$($trans['collaborators'])`",`n    `"collaboratorsSubtitle`": `"$($trans['collaboratorsSubtitle'])`",`n    `"graphicDesigner`": `"$($trans['graphicDesigner'])`",`n    `"graphicDesignDesc`": `"$($trans['graphicDesignDesc'])`",`n"
    $pattern = "(?m)(^\s+$lang:\s*\{)"
    $content = $content -replace $pattern, "`$1$additions"
}

Set-Content 'docs\translations.js' $content -Encoding UTF8
