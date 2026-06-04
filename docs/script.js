// SyndraShell - Interactive Script

// Install commands per team
const installCommands = {
    red: 'git clone --depth 1 https://github.com/Fud0o0/Syndra.git ~/.config/SyndraShell && bash ~/.config/SyndraShell/scripts/secure-install.sh red',
    blue: 'git clone --depth 1 https://github.com/Fud0o0/Syndra.git ~/.config/SyndraShell && bash ~/.config/SyndraShell/scripts/secure-install.sh blue',
    purple: 'git clone --depth 1 https://github.com/Fud0o0/Syndra.git ~/.config/SyndraShell && bash ~/.config/SyndraShell/scripts/secure-install.sh purple',
    root: 'git clone --depth 1 https://github.com/Fud0o0/Syndra.git ~/.config/SyndraShell && bash ~/.config/SyndraShell/scripts/secure-install.sh root',
    custom: 'git clone --depth 1 https://github.com/Fud0o0/Syndra.git ~/.config/SyndraShell && bash ~/.config/SyndraShell/scripts/secure-install.sh interactive'
};

// Disk space requirements per team
const diskSpaceRequired = {
    red: '15 GB',
    blue: '12 GB',
    purple: '25 GB',
    root: '18 GB',
    custom: '2 GB - 30 GB'
};

// Dynamic Tools per team
const teamTools = {
    red: [
        { category: 'Reconnaissance', tools: ['Nmap', 'Masscan', 'Amass', 'Subfinder'] },
        { category: 'Exploitation', tools: ['Metasploit', 'SQLmap', 'Burp Suite', 'Custom Scripts'] },
        { category: 'Post-Exploitation', tools: ['Mimikatz', 'BloodHound', 'Empire', 'LinPEAS'] },
        { category: 'Analysis', tools: ['Wireshark', 'CrackMapExec', 'Hashcat', 'John the Ripper'] }
    ],
    blue: [
        { category: 'Monitoring', tools: ['Zeek', 'Suricata', 'Snort', 'Wazuh'] },
        { category: 'Defense', tools: ['Fail2Ban', 'ModSecurity', 'UFW', 'AppArmor'] },
        { category: 'Analysis', tools: ['Splunk', 'ELK Stack', 'Wireshark', 'Autopsy'] },
        { category: 'Incident Response', tools: ['Velociraptor', 'TheHive', 'Cortex', 'MISP'] }
    ],
    purple: [
        { category: 'Recon & Exploitation', tools: ['Nmap', 'Metasploit', 'Burp Suite', 'BloodHound'] },
        { category: 'Monitoring & Defense', tools: ['Zeek', 'Wazuh', 'Suricata', 'Fail2Ban'] },
        { category: 'Analysis & Forensics', tools: ['Wireshark', 'Splunk', 'Autopsy', 'Velociraptor'] },
        { category: 'Adversary Emulation', tools: ['Caldera', 'Atomic Red Team', 'Cobalt Strike', 'Covenant'] }
    ],
    root: [
        { category: 'Reverse Engineering', tools: ['Ghidra', 'IDA Free', 'Radare2', 'Binary Ninja'] },
        { category: 'Pwn & Exploitation', tools: ['Pwntools', 'GDB/GEF', 'Ropper', 'Metasploit'] },
        { category: 'Forensics', tools: ['Volatility', 'Autopsy', 'Binwalk', 'Sleuth Kit'] },
        { category: 'Cryptography', tools: ['CyberChef', 'John the Ripper', 'Hashcat', 'RsaCtfTool'] }
    ],
    custom: [
        { category: 'Core Tools', tools: ['Nmap', 'Metasploit', 'Wireshark', 'Ghidra'] },
        { category: 'System Config', tools: ['Hyprland', 'Waybar', 'Kitty', 'Rofi'] },
        { category: 'Scripts', tools: ['Syndra Install', 'Update Script', 'Theme Switcher', 'Backup'] },
        { category: 'Extras', tools: ['Custom Scripts', 'User Binaries', 'Docker Containers', 'Podman'] }
    ]
};

// URLs for the tools
const toolUrls = {
    'Nmap': 'https://nmap.org/',
    'Masscan': 'https://github.com/robertdavidgraham/masscan',
    'Amass': 'https://github.com/owasp-amass/amass',
    'Subfinder': 'https://github.com/projectdiscovery/subfinder',
    'Metasploit': 'https://www.metasploit.com/',
    'SQLmap': 'https://sqlmap.org/',
    'Burp Suite': 'https://portswigger.net/burp',
    'Mimikatz': 'https://github.com/gentilkiwi/mimikatz',
    'BloodHound': 'https://github.com/BloodHoundAD/BloodHound',
    'Empire': 'https://github.com/BC-SECURITY/Empire',
    'LinPEAS': 'https://github.com/carlospolop/PEASS-ng',
    'Wireshark': 'https://www.wireshark.org/',
    'CrackMapExec': 'https://github.com/Porchetta-Industries/CrackMapExec',
    'Hashcat': 'https://hashcat.net/hashcat/',
    'John the Ripper': 'https://www.openwall.com/john/',
    'Zeek': 'https://zeek.org/',
    'Suricata': 'https://suricata.io/',
    'Snort': 'https://www.snort.org/',
    'Wazuh': 'https://wazuh.com/',
    'Fail2Ban': 'https://github.com/fail2ban/fail2ban',
    'ModSecurity': 'https://github.com/SpiderLabs/ModSecurity',
    'UFW': 'https://help.ubuntu.com/community/UFW',
    'AppArmor': 'https://gitlab.com/apparmor/apparmor',
    'Splunk': 'https://www.splunk.com/',
    'ELK Stack': 'https://www.elastic.co/elastic-stack',
    'Autopsy': 'https://www.sleuthkit.org/autopsy/',
    'Velociraptor': 'https://docs.velociraptor.app/',
    'TheHive': 'https://thehive-project.org/',
    'Cortex': 'https://thehive-project.org/',
    'MISP': 'https://www.misp-project.org/',
    'Caldera': 'https://caldera.mitre.org/',
    'Atomic Red Team': 'https://atomicredteam.io/',
    'Cobalt Strike': 'https://www.cobaltstrike.com/',
    'Covenant': 'https://github.com/cobbr/Covenant',
    'Ghidra': 'https://ghidra-sre.org/',
    'IDA Free': 'https://hex-rays.com/ida-free/',
    'Radare2': 'https://rada.re/n/',
    'Binary Ninja': 'https://binary.ninja/',
    'Pwntools': 'https://docs.pwntools.com/',
    'GDB/GEF': 'https://hugsy.github.io/gef/',
    'Ropper': 'https://github.com/sashs/Ropper',
    'Volatility': 'https://volatilityfoundation.org/',
    'Binwalk': 'https://github.com/ReFirmLabs/binwalk',
    'Sleuth Kit': 'https://www.sleuthkit.org/',
    'CyberChef': 'https://gchq.github.io/CyberChef/',
    'RsaCtfTool': 'https://github.com/RsaCtfTool/RsaCtfTool',
    'Hyprland': 'https://hyprland.org/',
    'Waybar': 'https://github.com/Alexays/Waybar',
    'Kitty': 'https://sw.kovidgoyal.net/kitty/',
    'Rofi': 'https://github.com/davatorium/rofi',
    'Docker Containers': 'https://www.docker.com/',
    'Podman': 'https://podman.io/'
};

// Initialize theme - force apply immediately
const savedTheme = localStorage.getItem('syndrashell-theme') || 'purple';

// Remove all possible theme classes and add the correct one
document.body.className = '';
document.body.classList.add(`${savedTheme}-theme`);

// Update install command based on theme
function updateInstallCommand(team) {
    const installCmd = document.getElementById('install-cmd');
    const diskSpaceText = document.getElementById('disk-space-text');
    
    if (installCmd) {
        installCmd.textContent = installCommands[team] || installCommands.purple;
    }
    
    if (diskSpaceText) {
        const diskLabels = {
            en: 'required', fr: 'requis', es: 'requerido', de: 'erforderlich', zh: '需要', ja: '必要',
            ko: '필요', it: 'richiesto', pt: 'necessário', ru: 'требуется', ar: 'مطلوب',
            hi: 'आवश्यक', tr: 'gerekli', nl: 'vereist', pl: 'wymagane', vi: 'cần'
        };
        const lang = window.currentLang || localStorage.getItem('syndraLang') || localStorage.getItem('syndrashell-lang') || 'fr';
        const label = diskLabels[lang] || diskLabels.en;
        diskSpaceText.textContent = `${diskSpaceRequired[team] || diskSpaceRequired.purple} ${label}`;
    }
}

// Update tools section based on theme
function updateToolsSection(team) {
    const container = document.getElementById('tools-container');
    const profileName = document.getElementById('tools-profile-name');
    
    // The description paragraph is the p element right before tools-container
    const sectionHeaderP = document.querySelector('#tools .section-header p');
    if (!container) return;

    // Translation maps for dynamic elements
    const lang = window.currentLang || localStorage.getItem('syndraLang') || localStorage.getItem('syndrashell-lang') || 'fr';
    const profileFormatted = team.charAt(0).toUpperCase() + team.slice(1) + " Team";
    
    const descriptions = {
        en: `Categorized toolsets dynamically loaded for the ${profileFormatted} profile.`,
        fr: `Ensembles d'outils catégorisés chargés dynamiquement pour le profil ${profileFormatted}.`,
        es: `Conjuntos de herramientas cargados dinámicamente para el perfil ${profileFormatted}.`,
        de: `Kategorisierte Toolsets, die dynamisch für das ${profileFormatted} Profil geladen werden.`,
        zh: `为 ${profileFormatted} 配置文件动态加载的分类工具集。`,
        ja: `${profileFormatted} プロファイル用に動的にロードされたカテゴリ別ツールセット。`,
        ko: `${profileFormatted} 프로필용으로 동적 로드된 분류별 도구 모음.`,
        it: `Set di strumenti caricati dinamicamente per il profilo ${profileFormatted}.`,
        pt: `Conjuntos de ferramentas categorizados carregados dinamicamente para o perfil ${profileFormatted}.`,
        ru: `Категоризированные наборы инструментов, динамически загружаемые для профиля ${profileFormatted}.`,
        ar: `مجموعات أدوات مصنفة يتم تحميلها ديناميكيًا لملف ${profileFormatted}.`,
        hi: `${profileFormatted} प्रोफ़ाइल के लिए गतिशील रूप से लोड किए गए श्रेणीबद्ध टूलसेट।`,
        tr: `${profileFormatted} profili için dinamik olarak yüklenen kategorize edilmiş araç setleri.`,
        nl: `Gecategoriseerde toolsets dynamisch geladen voor het ${profileFormatted} profiel.`,
        pl: `Skategoryzowane zestawy narzędzi ładowane dynamicznie dla profilu ${profileFormatted}.`,
        vi: `Các bộ công cụ được phân loại tải động cho cấu hình ${profileFormatted}.`
    };

    const catTranslations = {
        "Reconnaissance": {
            fr: "Reconnaissance", en: "Reconnaissance", pt: "Reconhecimento",
            ru: "Разведка", ar: "الاستطلاع", hi: "टोही", tr: "Keşif",
            nl: "Verkenning", pl: "Rozpoznanie", vi: "Trinh sát",
            ja: "偵察", es: "Reconocimiento", de: "Aufklärung", zh: "侦察", ko: "정찰", it: "Ricognizione"
        },
        "Exploitation": {
            fr: "Exploitation", en: "Exploitation", pt: "Exploração",
            ru: "Эксплуатация", ar: "الاستغلال", hi: "शोषण", tr: "İstismar",
            nl: "Exploitatie", pl: "Eksploitacja", vi: "Khai thác",
            ja: "エクスプロイト", es: "Explotación", de: "Ausbeutung", zh: "利用", ko: "익스플로잇", it: "Sfruttamento"
        },
        "Post-Exploitation": {
            fr: "Post-exploitation", en: "Post-Exploitation", pt: "Pós-Exploração",
            ru: "Пост-эксплуатация", ar: "ما بعد الاستغلال", hi: "शोषण के बाद", tr: "İstismar Sonrası",
            nl: "Post-Exploitatie", pl: "Post-Eksploitacja", vi: "Sau khai thác",
            ja: "ポストエクスプロイト", es: "Post-explotación", de: "Post-Exploitation", zh: "后渗透", ko: "포스트 익스플로잇", it: "Post-sfruttamento"
        },
        "Analysis": {
            fr: "Analyse", en: "Analysis", pt: "Análise",
            ru: "Анализ", ar: "التحليل", hi: "विश्लेषण", tr: "Analiz",
            nl: "Analyse", pl: "Analiza", vi: "Phân tích",
            ja: "分析", es: "Análisis", de: "Analyse", zh: "分析", ko: "분석", it: "Analisi"
        },
        "Monitoring": {
            fr: "Surveillance", en: "Monitoring", pt: "Monitoramento",
            ru: "Мониторинг", ar: "المراقبة", hi: "निगरानी", tr: "İzleme",
            nl: "Monitoring", pl: "Monitorowanie", vi: "Giám sát",
            ja: "モニタリング", es: "Monitoreo", de: "Überwachung", zh: "监控", ko: "모니터링", it: "Monitoraggio"
        },
        "Defense": {
            fr: "Défense", en: "Defense", pt: "Defesa",
            ru: "Защита", ar: "الدفاع", hi: "रक्षा", tr: "Savunma",
            nl: "Verdediging", pl: "Obrona", vi: "Phòng thủ",
            ja: "防御", es: "Defensa", de: "Verteidigung", zh: "防御", ko: "방어", it: "Difesa"
        },
        "Incident Response": {
            fr: "Réponse Incidents", en: "Incident Response", pt: "Resposta a Incidentes",
            ru: "Реагирование на инциденты", ar: "الاستجابة للحوادث", hi: "घटना प्रतिक्रिया", tr: "Olay Müdahalesi",
            nl: "Incidentrespons", pl: "Reagowanie na incydenty", vi: "Phản ứng sự cố",
            ja: "インシデント対応", es: "Respuesta a Incidentes", de: "Vorfallreaktion", zh: "事件响应", ko: "사고 대응", it: "Risposta agli incidenti"
        },
        "Recon & Exploitation": {
            fr: "Recon & Exploitation", en: "Recon & Exploitation", pt: "Recon & Exploração",
            ru: "Разведка и эксплуатация", ar: "الاستطلاع والاستغلال", hi: "टोही और शोषण", tr: "Keşif & İstismar",
            nl: "Verkenning & Exploitatie", pl: "Rozpoznanie & Eksploitacja", vi: "Trinh sát & Khai thác",
            ja: "偵察とエクスプロイト", es: "Recon y Explotación", de: "Recon & Ausbeutung", zh: "侦察与利用", ko: "정찰 및 익스플로잇", it: "Recon e Sfruttamento"
        },
        "Monitoring & Defense": {
            fr: "Surveillance & Défense", en: "Monitoring & Defense", pt: "Monitoramento & Defesa",
            ru: "Мониторинг и защита", ar: "المراقبة والدفاع", hi: "निगरानी और रक्षा", tr: "İzleme & Savunma",
            nl: "Monitoring & Verdediging", pl: "Monitorowanie & Obrona", vi: "Giám sát & Phòng thủ",
            ja: "監視と防御", es: "Monitoreo y Defensa", de: "Überwachung & Verteidigung", zh: "监控与防御", ko: "모니터링 및 방어", it: "Monitoraggio e Difesa"
        },
        "Analysis & Forensics": {
            fr: "Analyse & Forensics", en: "Analysis & Forensics", pt: "Análise & Forense",
            ru: "Анализ и криминалистика", ar: "التحليل والجنائيات", hi: "विश्लेषण और फोरेंसिक", tr: "Analiz & Adli Bilişim",
            nl: "Analyse & Forensics", pl: "Analiza & Kryminalistyka", vi: "Phân tích & Pháp y",
            ja: "分析とフォレンジック", es: "Análisis y Forense", de: "Analyse & Forensik", zh: "分析与取证", ko: "분석 및 포렌식", it: "Analisi e Forense"
        },
        "Adversary Emulation": {
            fr: "Émulation d'Adversaire", en: "Adversary Emulation", pt: "Emulação de Adversários",
            ru: "Эмуляция противника", ar: "محاكاة الخصم", hi: "प्रतिद्वंद्वी अनुकरण", tr: "Rakip Emülasyonu",
            nl: "Tegenstander Emulatie", pl: "Emulacja przeciwnika", vi: "Giả lập đối thủ",
            ja: "攻撃者エミュレーション", es: "Emulación de Adversarios", de: "Gegner-Emulation", zh: "对手模拟", ko: "적대자 에뮬레이션", it: "Emulazione dell'avversario"
        },
        "Reverse Engineering": {
            fr: "Reverse Engineering", en: "Reverse Engineering", pt: "Engenharia Reversa",
            ru: "Реверс-инжиниринг", ar: "الهندسة العكسية", hi: "रिवर्स इंजीनियरिंग", tr: "Tersine Mühendislik",
            nl: "Reverse Engineering", pl: "Inżynieria wsteczna", vi: "Dịch ngược",
            ja: "リバースエンジニアリング", es: "Ingeniería Inversa", de: "Reverse Engineering", zh: "逆向工程", ko: "리버스 엔지니어링", it: "Ingegneria Inversa"
        },
        "Pwn & Exploitation": {
            fr: "Pwn & Exploitation", en: "Pwn & Exploitation", pt: "Pwn & Exploração",
            ru: "Pwn и эксплуатация", ar: "اختراق واستغلال", hi: "Pwn और शोषण", tr: "Pwn & İstismar",
            nl: "Pwn & Exploitatie", pl: "Pwn & Eksploitacja", vi: "Pwn & Khai thác",
            ja: "Pwnとエクスプロイト", es: "Pwn y Explotación", de: "Pwn & Ausbeutung", zh: "Pwn与利用", ko: "Pwn 및 익스플로잇", it: "Pwn e Sfruttamento"
        },
        "Forensics": {
            fr: "Forensics", en: "Forensics", pt: "Forense",
            ru: "Криминалистика", ar: "الجنائيات الرقمية", hi: "डिजिटल फोरेंसिक", tr: "Adli Bilişim",
            nl: "Forensisch onderzoek", pl: "Kryminalistyka", vi: "Pháp y số",
            ja: "フォレンジック", es: "Forense", de: "Forensik", zh: "取证", ko: "포렌식", it: "Forense"
        },
        "Cryptography": {
            fr: "Cryptographie", en: "Cryptography", pt: "Criptografia",
            ru: "Криптография", ar: "التشفير", hi: "क्रिप्टोग्राफी", tr: "Kriptografi",
            nl: "Cryptografie", pl: "Kryptografia", vi: "Mật mã học",
            ja: "暗号", es: "Criptografía", de: "Kryptographie", zh: "密码学", ko: "암호학", it: "Crittografia"
        },
        "Core Tools": {
            fr: "Outils de base", en: "Core Tools", pt: "Ferramentas Base",
            ru: "Основные инструменты", ar: "الأدوات الأساسية", hi: "मूल उपकरण", tr: "Temel Araçlar",
            nl: "Kerntools", pl: "Podstawowe narzędzia", vi: "Công cụ cốt lõi",
            ja: "コアツール", es: "Herramientas Base", de: "Kern-Tools", zh: "核心工具", ko: "핵심 도구", it: "Strumenti di Base"
        },
        "System Config": {
            fr: "Configuration Système", en: "System Config", pt: "Configuração do Sistema",
            ru: "Конфигурация системы", ar: "إعداد النظام", hi: "सिस्टम कॉन्फ़िग", tr: "Sistem Yapılandırması",
            nl: "Systeemconfiguratie", pl: "Konfiguracja systemu", vi: "Cấu hình hệ thống",
            ja: "システム設定", es: "Configuración de Sistema", de: "Systemkonfiguration", zh: "系统配置", ko: "시스템 설정", it: "Configurazione di Sistema"
        },
        "Scripts": {
            fr: "Scripts", en: "Scripts", pt: "Scripts",
            ru: "Скрипты", ar: "البرامج النصية", hi: "स्क्रिप्ट", tr: "Komut dosyaları",
            nl: "Scripts", pl: "Skrypty", vi: "Tập lệnh",
            ja: "スクリプト", es: "Scripts", de: "Skripte", zh: "脚本", ko: "스크립트", it: "Script"
        },
        "Extras": {
            fr: "Extras", en: "Extras", pt: "Extras",
            ru: "Дополнения", ar: "إضافات", hi: "अतिरिक्त", tr: "Ekstralar",
            nl: "Extra's", pl: "Dodatki", vi: "Bổ sung",
            ja: "追加ツール", es: "Extras", de: "Extras", zh: "额外工具", ko: "추가 기능", it: "Extra"
        }
    };

    // Update dynamic description paragraph
    if (sectionHeaderP) {
        sectionHeaderP.removeAttribute('data-i18n'); // prevent default translation logic
        sectionHeaderP.textContent = descriptions[lang] || descriptions.en;
    }

    // Set profile name in case it's used elsewhere
    if (profileName) {
        profileName.textContent = profileFormatted;
    }
    
    // Clear current tools
    container.innerHTML = '';
    
    const tools = teamTools[team] || teamTools.purple;
    
    // Build tools columns
    tools.forEach(group => {
        const listDiv = document.createElement('div');
        listDiv.className = 'command-list';
        
        const title = document.createElement('h3');
        // Apply translated category title
        title.textContent = (catTranslations[group.category] && catTranslations[group.category][lang]) ? catTranslations[group.category][lang] : group.category;
        listDiv.appendChild(title);
        
        const ul = document.createElement('ul');
        group.tools.forEach(tool => {
            const li = document.createElement('li');
            
            if (toolUrls[tool]) {
                const a = document.createElement('a');
                a.href = toolUrls[tool];
                a.target = '_blank';
                a.rel = 'noopener noreferrer';
                a.textContent = tool;
                li.appendChild(a);
            } else {
                const span = document.createElement('span');
                span.textContent = tool;
                li.appendChild(span);
            }
            
            ul.appendChild(li);
        });
        
        listDiv.appendChild(ul);
        container.appendChild(listDiv);
    });
}

// Update tagline based on theme and language
function updateTagline(team) {
    const badge = document.querySelector('.hero-badge');
    if (!badge) return;
    
    const lang = window.currentLang || localStorage.getItem('syndraLang') || localStorage.getItem('syndrashell-lang') || 'fr';
    
    const taglines = {
        en: {
            red:    "For Offensive Security & Pentesting",
            blue:   "For Defense, Monitoring & DFIR",
            purple: "For Red, Blue & Purple Teams",
            root:   "For CTF, Reverse Engineering & Pwn",
            custom: "For Your Custom Environment"
        },
        fr: {
            red:    "Pour la Sécurité Offensive & le Pentest",
            blue:   "Pour la Défense, le Monitoring & DFIR",
            purple: "Pour les équipes Red, Blue et Purple",
            root:   "Pour le CTF, Reverse Engineering & Pwn",
            custom: "Pour votre environnement personnalisé"
        },
        es: {
            red:    "Para Seguridad Ofensiva y Pentesting",
            blue:   "Para Defensa, Monitoreo y DFIR",
            purple: "Para Equipos Red, Blue y Purple",
            root:   "Para CTF, Ingeniería Inversa y Pwn",
            custom: "Para su Entorno Personalizado"
        },
        de: {
            red:    "Für Offensive Sicherheit & Pentesting",
            blue:   "Für Verteidigung, Monitoring & DFIR",
            purple: "Für Red, Blue & Purple Teams",
            root:   "Für CTF, Reverse Engineering & Pwn",
            custom: "Für Ihre benutzerdefinierte Umgebung"
        },
        zh: {
            red:    "用于进攻性安全和渗透测试",
            blue:   "用于防御、监控和DFIR",
            purple: "用于红队、蓝队和紫队",
            root:   "用于CTF、逆向工程和Pwn",
            custom: "用于您的自定义环境"
        },
        ja: {
            red:    "攻撃的セキュリティとペンテスト向け",
            blue:   "防御、監視、DFIRのために",
            purple: "Red、Blue、Purple Teamのために",
            root:   "CTF、リバースエンジニアリング、Pwn向け",
            custom: "カスタム環境のために"
        },
        ko: {
            red:    "공격적 보안 및 침투 테스트",
            blue:   "방어, 모니터링 및 DFIR",
            purple: "Red, Blue 및 Purple Team용",
            root:   "CTF, 리버스 엔지니어링 및 Pwn용",
            custom: "맞춤형 환경을 위해"
        },
        it: {
            red:    "Per Sicurezza Offensiva e Pentesting",
            blue:   "Per Difesa, Monitoraggio e DFIR",
            purple: "Per Team Red, Blue e Purple",
            root:   "Per CTF, Reverse Engineering e Pwn",
            custom: "Per il tuo Ambiente Personalizzato"
        },
        pt: {
            red:    "Para Segurança Ofensiva e Pentest",
            blue:   "Para Defesa, Monitorização e DFIR",
            purple: "Para Equipas Red, Blue e Purple",
            root:   "Para CTF, Engenharia Reversa e Pwn",
            custom: "Para o Seu Ambiente Personalizado"
        },
        ru: {
            red:    "Для наступательной безопасности и пентеста",
            blue:   "Для защиты, мониторинга и DFIR",
            purple: "Для команд Red, Blue и Purple",
            root:   "Для CTF, реверс-инжиниринга и Pwn",
            custom: "Для вашей пользовательской среды"
        },
        ar: {
            red:    "لأمن الهجوم واختبار الاختراق",
            blue:   "للدفاع والمراقبة وDFIR",
            purple: "للفرق الحمراء والزرقاء والبنفسجية",
            root:   "لـCTF والهندسة العكسية وPwn",
            custom: "لبيئتك المخصصة"
        },
        hi: {
            red:    "आक्रामक सुरक्षा और पेंटेस्टिंग के लिए",
            blue:   "रक्षा, निगरानी और DFIR के लिए",
            purple: "Red, Blue और Purple टीमों के लिए",
            root:   "CTF, रिवर्स इंजीनियरिंग और Pwn के लिए",
            custom: "आपके कस्टम वातावरण के लिए"
        },
        tr: {
            red:    "Saldırı Güvenliği ve Pentesting İçin",
            blue:   "Savunma, İzleme ve DFIR İçin",
            purple: "Red, Blue ve Purple Takımları İçin",
            root:   "CTF, Tersine Mühendislik ve Pwn İçin",
            custom: "Özel Ortamınız İçin"
        },
        nl: {
            red:    "Voor Offensieve Beveiliging & Pentesting",
            blue:   "Voor Verdediging, Monitoring & DFIR",
            purple: "Voor Red, Blue & Purple Teams",
            root:   "Voor CTF, Reverse Engineering & Pwn",
            custom: "Voor Uw Aangepaste Omgeving"
        },
        pl: {
            red:    "Dla Ofensywnego Bezpieczeństwa i Pentestów",
            blue:   "Dla Obrony, Monitorowania i DFIR",
            purple: "Dla Zespołów Red, Blue i Purple",
            root:   "Dla CTF, Inżynierii Wstecznej i Pwn",
            custom: "Dla Twojego Niestandardowego Środowiska"
        },
        vi: {
            red:    "Cho Bảo mật Tấn công & Kiểm thử Xâm nhập",
            blue:   "Cho Phòng thủ, Giám sát & DFIR",
            purple: "Cho Đội Đỏ, Đội Xanh & Đội Tím",
            root:   "Cho CTF, Dịch ngược & Pwn",
            custom: "Cho Môi trường Tùy chỉnh của Bạn"
        }
    };
    
    // Fallback to English
    const currentTaglines = taglines[lang] || taglines.en;
    
    // Remove data-i18n to prevent conflict with generic translations.js logic
    badge.removeAttribute('data-i18n');
    badge.textContent = currentTaglines[team] || currentTaglines.purple;
}

// Set initial install command when DOM is ready
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', () => {
        updateInstallCommand(savedTheme);
        updateToolsSection(savedTheme);
        updateTagline(savedTheme);
        setActivePill(savedTheme);
    });
} else {
    updateInstallCommand(savedTheme);
    updateToolsSection(savedTheme);
    updateTagline(savedTheme);
    setActivePill(savedTheme);
}

// Also update tagline and tools if language changes
document.addEventListener('DOMContentLoaded', () => {
    // Listen for custom language change event or re-render when translatePage is called
    const origSetLanguage = window.setLanguage;
    if (origSetLanguage) {
        window.setLanguage = function(lang) {
            origSetLanguage(lang);
            const currentTheme = localStorage.getItem('syndrashell-theme') || 'purple';
            updateTagline(currentTheme);
            updateToolsSection(currentTheme);
            updateInstallCommand(currentTheme);
        };
    }

    // Also catch dropdown click (legacy support)
    const langSelector = document.querySelector('.lang-options');
    if (langSelector) {
        langSelector.addEventListener('click', () => {
            setTimeout(() => {
                const currentTheme = localStorage.getItem('syndrashell-theme') || 'purple';
                updateTagline(currentTheme);
                updateToolsSection(currentTheme);
                updateInstallCommand(currentTheme);
            }, 100);
        });
    }
});

// Set active pill based on saved theme
function setActivePill(theme) {
    const pills = document.querySelectorAll('.pill');
    pills.forEach(pill => {
        pill.classList.remove('active');
        if (pill.getAttribute('data-team') === theme) {
            pill.classList.add('active');
        }
    });
}

const pills = document.querySelectorAll('.pill');

pills.forEach(pill => {
    pill.addEventListener('click', function() {
        const team = this.getAttribute('data-team');
        
        // Remove active from all
        pills.forEach(p => p.classList.remove('active'));
        
        // Add active to clicked
        this.classList.add('active');
        
        // Change theme with animation - force complete class replacement
        document.body.style.transition = 'background 0.8s cubic-bezier(0.4, 0, 0.2, 1)';
        document.body.className = '';
        document.body.classList.add(`${team}-theme`);
        
        // Sync html data-theme attribute so CSS pre-render rules stay correct
        document.documentElement.setAttribute('data-theme', team);
        
        // Update install command
        updateInstallCommand(team);
        
        // Update tools
        updateToolsSection(team);
        
        // Update tagline
        updateTagline(team);
        
        // Update logo color (glow effect)
        updateLogoColor(team);
        
        // Save preference
        localStorage.setItem('syndrashell-theme', team);
    });
});

// Update logo color based on theme (legacy filter-based, kept for fallback)
function updateLogoColor(theme) {
    // Inline SVGs now use CSS classes - no JS needed for color
    // But we keep a glow filter for visual enhancement
    const themeGlows = {
        red:    'drop-shadow(0 0 12px rgba(255,0,102,0.7))',
        blue:   'drop-shadow(0 0 12px rgba(0,212,255,0.7))',
        purple: 'drop-shadow(0 0 12px rgba(179,102,255,0.7))',
        root:   'drop-shadow(0 0 12px rgba(255,255,255,0.5))',
        custom: 'drop-shadow(0 0 12px rgba(0,255,136,0.7))'
    };
    const glow = themeGlows[theme] || themeGlows.purple;
    document.querySelectorAll('.syndra-logo-inline').forEach(el => {
        el.style.filter = glow;
    });
}

// Apply logo glow immediately on load (no delay needed - color handled by CSS)
document.addEventListener('DOMContentLoaded', () => {
    const savedTheme = localStorage.getItem('syndrashell-theme') || 'purple';
    updateLogoColor(savedTheme);
});

// Add particle effects
function createParticles() {
    const particlesContainer = document.createElement('div');
    particlesContainer.className = 'particles-container';
    particlesContainer.style.cssText = `
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        pointer-events: none;
        z-index: 0;
        overflow: hidden;
    `;
    document.body.insertBefore(particlesContainer, document.body.firstChild);

    for (let i = 0; i < 15; i++) {
        const particle = document.createElement('div');
        particle.className = 'particle';
        
        const size = Math.random() * 3 + 1;
        const duration = Math.random() * 20 + 15;
        const delay = Math.random() * 5;
        const xPos = Math.random() * 100;
        
        particle.style.cssText = `
            position: absolute;
            width: ${size}px;
            height: ${size}px;
            background: rgba(255, 255, 255, 0.4);
            border-radius: 50%;
            left: ${xPos}%;
            bottom: -10px;
            animation: float-up ${duration}s linear ${delay}s infinite;
            will-change: transform;
        `;
        
        particlesContainer.appendChild(particle);
    }

    // Add CSS animation
    if (!document.getElementById('particle-animation')) {
        const style = document.createElement('style');
        style.id = 'particle-animation';
        style.textContent = `
            @keyframes float-up {
                0% {
                    transform: translateY(0) translateX(0);
                    opacity: 0;
                }
                10% {
                    opacity: 0.5;
                }
                90% {
                    opacity: 0.5;
                }
                100% {
                    transform: translateY(-100vh) translateX(${Math.random() * 100 - 50}px);
                    opacity: 0;
                }
            }
        `;
        document.head.appendChild(style);
    }
}

// Initialize particles after page load
window.addEventListener('load', () => {
    createParticles();
});

// Add smooth scroll
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            target.scrollIntoView({
                behavior: 'smooth',
                block: 'start'
            });
        }
    });
});

// Add copy confirmation animation
document.addEventListener('DOMContentLoaded', () => {
    const copyBtn = document.getElementById('copy-install-btn');
    if (copyBtn) {
        copyBtn.addEventListener('click', function() {
            const installCmd = document.getElementById('install-cmd');
            const cmdText = installCmd ? installCmd.textContent : '';
            
            // Copy to clipboard
            navigator.clipboard.writeText(cmdText).then(() => {
                const originalHTML = this.innerHTML;
                this.innerHTML = '<span style="font-size: 14px;">✓</span>';
                this.style.transform = 'scale(1.2)';
                
                setTimeout(() => {
                    this.innerHTML = originalHTML;
                    this.style.transform = '';
                }, 1000);
            });
        });
    }
});

console.log('%cSyndra', 'color: #b366ff; font-size: 24px; font-weight: bold; text-shadow: 0 0 10px #b366ff;');
console.log('%cAdvanced Cybersecurity Environment', 'color: #d699ff; font-size: 14px;');

// ===== Custom Language Dropdown =====
document.addEventListener('DOMContentLoaded', () => {
    const dropdown   = document.getElementById('lang-dropdown');
    const trigger    = document.getElementById('lang-trigger');
    const options    = document.querySelectorAll('.lang-option');
    const labelEl    = document.getElementById('lang-selected-label');
    const nativeSelect = document.getElementById('language-selector');

    if (!dropdown || !trigger) return;

    // Label map: value -> short label shown in trigger
    const labelMap = { fr: 'FR', en: 'EN', es: 'ES', de: 'DE', zh: '中文', ja: '日本語', ko: '한국어', it: 'IT', pt: 'PT', ru: 'RU', ar: 'AR', hi: 'HI', tr: 'TR', nl: 'NL', pl: 'PL', vi: 'VI' };

    // Restore saved lang label - use 'syndraLang' key (same as translations.js)
    const savedLang = localStorage.getItem('syndraLang') || localStorage.getItem('syndrashell-lang') || 'fr';
    if (labelEl) labelEl.textContent = labelMap[savedLang] || savedLang.toUpperCase();
    options.forEach(opt => {
        opt.classList.toggle('selected', opt.dataset.value === savedLang);
    });
    if (nativeSelect) nativeSelect.value = savedLang;

    // Toggle open/close
    trigger.addEventListener('click', (e) => {
        e.stopPropagation();
        const isOpen = dropdown.classList.toggle('open');
        trigger.setAttribute('aria-expanded', isOpen);
    });

    // Select an option
    options.forEach(opt => {
        opt.addEventListener('click', () => {
            const val = opt.dataset.value;

            // Update label
            if (labelEl) labelEl.textContent = labelMap[val] || val.toUpperCase();

            // Mark selected
            options.forEach(o => o.classList.remove('selected'));
            opt.classList.add('selected');

            // Call translations.js setLanguage (saves to 'syndraLang' and translates page)
            if (window.setLanguage) {
                window.setLanguage(val);
            } else if (nativeSelect) {
                nativeSelect.value = val;
                nativeSelect.dispatchEvent(new Event('change'));
            }

            // Close dropdown
            dropdown.classList.remove('open');
            trigger.setAttribute('aria-expanded', 'false');
        });
    });

    // Close on outside click
    document.addEventListener('click', (e) => {
        if (!dropdown.contains(e.target)) {
            dropdown.classList.remove('open');
            trigger.setAttribute('aria-expanded', 'false');
        }
    });

    // Close on Escape
    document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape') {
            dropdown.classList.remove('open');
            trigger.setAttribute('aria-expanded', 'false');
        }
    });
});



