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

// Set initial install command when DOM is ready
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', () => {
        updateInstallCommand(savedTheme);
        setActivePill(savedTheme);
    });
} else {
    updateInstallCommand(savedTheme);
    setActivePill(savedTheme);
}

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

    for (let i = 0; i < 30; i++) {
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
            background: rgba(255, 255, 255, 0.3);
            border-radius: 50%;
            left: ${xPos}%;
            bottom: -10px;
            animation: float-up ${duration}s linear ${delay}s infinite;
            box-shadow: 0 0 10px rgba(255, 255, 255, 0.5);
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



