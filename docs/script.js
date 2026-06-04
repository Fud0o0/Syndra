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
        diskSpaceText.textContent = `${diskSpaceRequired[team] || diskSpaceRequired.purple} requis`;
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
    const lang = window.currentLang || localStorage.getItem('syndrashell-lang') || 'en';
    const profileFormatted = team.charAt(0).toUpperCase() + team.slice(1) + " Team";
    
    const descriptions = {
        en: `Categorized toolsets dynamically loaded for the ${profileFormatted} profile.`,
        fr: `Ensembles d'outils catégorisés chargés dynamiquement pour le profil ${profileFormatted}.`,
        ja: `${profileFormatted} プロファイル用に動的にロードされたカテゴリ別ツールセット。`,
        es: `Conjuntos de herramientas cargados dinámicamente para el perfil ${profileFormatted}.`,
        de: `Kategorisierte Toolsets, die dynamisch für das ${profileFormatted} Profil geladen werden.`,
        zh: `为 ${profileFormatted} 配置文件动态加载的分类工具集。`,
        ko: `${profileFormatted} 프로필용으로 동적 로드된 분류별 도구 모음.`,
        it: `Set di strumenti caricati dinamicamente per il profilo ${profileFormatted}.`
    };

    const catTranslations = {
        "Reconnaissance": { fr: "Reconnaissance", ja: "偵察", es: "Reconocimiento", de: "Aufklärung", zh: "侦察", ko: "정찰", it: "Ricognizione" },
        "Exploitation": { fr: "Exploitation", ja: "エクスプロイト", es: "Explotación", de: "Ausbeutung", zh: "利用", ko: "익스플로잇", it: "Sfruttamento" },
        "Post-Exploitation": { fr: "Post-exploitation", ja: "ポストエクスプロイト", es: "Post-explotación", de: "Post-Exploitation", zh: "后渗透", ko: "포스트 익스플로잇", it: "Post-sfruttamento" },
        "Analysis": { fr: "Analyse", ja: "分析", es: "Análisis", de: "Analyse", zh: "分析", ko: "분석", it: "Analisi" },
        "Monitoring": { fr: "Surveillance", ja: "モニタリング", es: "Monitoreo", de: "Überwachung", zh: "监控", ko: "모니터링", it: "Monitoraggio" },
        "Defense": { fr: "Défense", ja: "防御", es: "Defensa", de: "Verteidigung", zh: "防御", ko: "방어", it: "Difesa" },
        "Incident Response": { fr: "Réponse Incidents", ja: "インシデント対応", es: "Respuesta a Incidentes", de: "Vorfallreaktion", zh: "事件响应", ko: "사고 대응", it: "Risposta agli incidenti" },
        "Recon & Exploitation": { fr: "Recon & Exploitation", ja: "偵察とエクスプロイト", es: "Recon y Explotación", de: "Recon & Ausbeutung", zh: "侦察与利用", ko: "정찰 및 익스플로잇", it: "Recon e Sfruttamento" },
        "Monitoring & Defense": { fr: "Surveillance & Défense", ja: "監視と防御", es: "Monitoreo y Defensa", de: "Überwachung & Verteidigung", zh: "监控与防御", ko: "모니터링 및 방어", it: "Monitoraggio e Difesa" },
        "Analysis & Forensics": { fr: "Analyse & Forensics", ja: "分析とフォレンジック", es: "Análisis y Forense", de: "Analyse & Forensik", zh: "分析与取证", ko: "분석 및 포렌식", it: "Analisi e Forense" },
        "Adversary Emulation": { fr: "Émulation d'Adversaire", ja: "攻撃者エミュレーション", es: "Emulación de Adversarios", de: "Gegner-Emulation", zh: "对手模拟", ko: "적대자 에뮬레이션", it: "Emulazione dell'avversario" },
        "Reverse Engineering": { fr: "Reverse Engineering", ja: "リバースエンジニアリング", es: "Ingeniería Inversa", de: "Reverse Engineering", zh: "逆向工程", ko: "리버스 엔지니어링", it: "Ingegneria Inversa" },
        "Pwn & Exploitation": { fr: "Pwn & Exploitation", ja: "Pwnとエクスプロイト", es: "Pwn y Explotación", de: "Pwn & Ausbeutung", zh: "Pwn与利用", ko: "Pwn 및 익스플로잇", it: "Pwn e Sfruttamento" },
        "Forensics": { fr: "Forensics", ja: "フォレンジック", es: "Forense", de: "Forensik", zh: "取证", ko: "포렌식", it: "Forense" },
        "Cryptography": { fr: "Cryptographie", ja: "暗号", es: "Criptografía", de: "Kryptographie", zh: "密码学", ko: "암호학", it: "Crittografia" },
        "Core Tools": { fr: "Outils de base", ja: "コアツール", es: "Herramientas Base", de: "Kern-Tools", zh: "核心工具", ko: "핵심 도구", it: "Strumenti di Base" },
        "System Config": { fr: "Configuration Système", ja: "システム設定", es: "Configuración de Sistema", de: "Systemkonfiguration", zh: "系统配置", ko: "시스템 설정", it: "Configurazione di Sistema" },
        "Scripts": { fr: "Scripts", ja: "スクリプト", es: "Scripts", de: "Skripte", zh: "脚本", ko: "스크립트", it: "Script" },
        "Extras": { fr: "Extras", ja: "追加ツール", es: "Extras", de: "Extras", zh: "额外工具", ko: "추가 기능", it: "Extra" }
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
            const span = document.createElement('span');
            span.textContent = tool;
            li.appendChild(span);
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
    
    const lang = window.currentLang || localStorage.getItem('syndrashell-lang') || 'en';
    
    const taglines = {
        en: {
            red: "For Offensive Security & Pentesting",
            blue: "For Defense, Monitoring & DFIR",
            purple: "For Red, Blue & Purple Teams",
            root: "For CTF, Reverse Engineering & Pwn",
            custom: "For Your Custom Environment"
        },
        fr: {
            red: "Pour la Sécurité Offensive & le Pentest",
            blue: "Pour la Défense, le Monitoring & DFIR",
            purple: "Pour les équipes Red, Blue et Purple",
            root: "Pour le CTF, Reverse Engineering & Pwn",
            custom: "Pour votre environnement personnalisé"
        },
        es: {
            red: "Para Seguridad Ofensiva y Pentesting",
            blue: "Para Defensa, Monitoreo y DFIR",
            purple: "Para Equipos Red, Blue y Purple",
            root: "Para CTF, Ingeniería Inversa y Pwn",
            custom: "Para su Entorno Personalizado"
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
    const langSelector = document.querySelector('.lang-options');
    if (langSelector) {
        langSelector.addEventListener('click', () => {
            setTimeout(() => {
                const currentTheme = localStorage.getItem('syndrashell-theme') || 'purple';
                updateTagline(currentTheme);
                updateToolsSection(currentTheme);
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
    const labelMap = { fr: 'FR', en: 'EN', es: 'ES', de: 'DE', zh: '中文', ja: '日本語', ko: '한국어', it: 'IT' };

    // Restore saved lang label
    const savedLang = localStorage.getItem('syndrashell-lang') || 'fr';
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

            // Sync native select and trigger translations.js change event
            if (nativeSelect) {
                nativeSelect.value = val;
                nativeSelect.dispatchEvent(new Event('change'));
            }

            // Save
            localStorage.setItem('syndrashell-lang', val);

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



