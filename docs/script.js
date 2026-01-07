// SyndraShell - Interactive Script

// Install commands per team
const installCommands = {
    red: 'curl -L get.syndra.me/red.sh | sh',
    blue: 'curl -L get.syndra.me/blue.sh | sh',
    purple: 'curl -L get.syndra.me/purple.sh | sh',
    root: 'curl -L get.syndra.me/root.sh | sh'
};

// Disk space requirements per team
const diskSpaceRequired = {
    red: '15 GB',
    blue: '12 GB',
    purple: '25 GB',
    root: '18 GB'
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
        
        // Update install command
        updateInstallCommand(team);
        
        // Save preference
        localStorage.setItem('syndrashell-theme', team);
    });
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

