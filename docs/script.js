// SyndraShell - Interactive Dashboard Script

// Initialize theme from localStorage or default to purple
const savedTheme = localStorage.getItem('syndrashell-theme') || 'purple';
document.body.classList.add(`${savedTheme}-theme`);

// Get team buttons
const teamButtons = document.querySelectorAll('.team-btn');

// Add click event listeners to team buttons
teamButtons.forEach(button => {
    button.addEventListener('click', function() {
        const selectedTeam = this.getAttribute('data-team');
        switchTheme(selectedTeam);
    });
});

// Function to switch theme
function switchTheme(team) {
    // Remove existing theme classes
    document.body.classList.remove('purple-theme', 'blue-theme');
    
    // Add new theme class
    document.body.classList.add(`${team}-theme`);
    
    // Save theme preference
    localStorage.setItem('syndrashell-theme', team);
    
    // Add animation effect
    createParticleEffect(team);
    
    // Show notification
    showNotification(`${team.charAt(0).toUpperCase() + team.slice(1)} Team activated!`);
}

// Create particle effect when switching themes
function createParticleEffect(team) {
    const colors = {
        purple: ['#8b5cf6', '#a78bfa', '#7c3aed'],
        blue: ['#3b82f6', '#60a5fa', '#2563eb']
    };
    
    const particleCount = 30;
    
    for (let i = 0; i < particleCount; i++) {
        const particle = document.createElement('div');
        particle.style.position = 'fixed';
        particle.style.width = '8px';
        particle.style.height = '8px';
        particle.style.borderRadius = '50%';
        particle.style.backgroundColor = colors[team][Math.floor(Math.random() * 3)];
        particle.style.left = Math.random() * window.innerWidth + 'px';
        particle.style.top = Math.random() * window.innerHeight + 'px';
        particle.style.pointerEvents = 'none';
        particle.style.zIndex = '9999';
        particle.style.opacity = '1';
        particle.style.transition = 'all 1s ease-out';
        
        document.body.appendChild(particle);
        
        // Animate particle
        setTimeout(() => {
            particle.style.transform = `translate(${(Math.random() - 0.5) * 200}px, ${Math.random() * 200 + 100}px) scale(0)`;
            particle.style.opacity = '0';
        }, 10);
        
        // Remove particle after animation
        setTimeout(() => {
            particle.remove();
        }, 1100);
    }
}

// Show notification
function showNotification(message) {
    // Remove existing notifications
    const existingNotif = document.querySelector('.notification');
    if (existingNotif) {
        existingNotif.remove();
    }
    
    const notification = document.createElement('div');
    notification.className = 'notification';
    notification.textContent = message;
    notification.style.cssText = `
        position: fixed;
        top: 20px;
        right: 20px;
        padding: 1rem 2rem;
        background: rgba(30, 30, 46, 0.95);
        backdrop-filter: blur(10px);
        border: 2px solid;
        border-radius: 12px;
        color: #e2e8f0;
        font-family: 'JetBrains Mono', monospace;
        font-weight: 600;
        z-index: 10000;
        animation: slideIn 0.3s ease-out;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
    `;
    
    const currentTheme = localStorage.getItem('syndrashell-theme') || 'purple';
    notification.style.borderColor = currentTheme === 'purple' ? '#8b5cf6' : '#3b82f6';
    
    document.body.appendChild(notification);
    
    // Remove notification after 3 seconds
    setTimeout(() => {
        notification.style.animation = 'slideOut 0.3s ease-out';
        setTimeout(() => notification.remove(), 300);
    }, 3000);
}

// Add CSS animations
const style = document.createElement('style');
style.textContent = `
    @keyframes slideIn {
        from {
            transform: translateX(100%);
            opacity: 0;
        }
        to {
            transform: translateX(0);
            opacity: 1;
        }
    }
    
    @keyframes slideOut {
        from {
            transform: translateX(0);
            opacity: 1;
        }
        to {
            transform: translateX(100%);
            opacity: 0;
        }
    }
    
    @keyframes glow {
        0%, 100% {
            opacity: 1;
        }
        50% {
            opacity: 0.7;
        }
    }
`;
document.head.appendChild(style);

// Add smooth scroll behavior
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

// Add parallax effect to cards on scroll
window.addEventListener('scroll', function() {
    const cards = document.querySelectorAll('.card');
    cards.forEach((card, index) => {
        const speed = 0.5 + (index * 0.1);
        const yPos = window.pageYOffset * speed;
        card.style.transform = `translateY(${yPos * 0.02}px)`;
    });
});

// Add typing effect to profile subtitle
const subtitle = document.querySelector('.profile-subtitle');
if (subtitle) {
    const text = subtitle.textContent;
    subtitle.textContent = '';
    let i = 0;
    
    function typeWriter() {
        if (i < text.length) {
            subtitle.textContent += text.charAt(i);
            i++;
            setTimeout(typeWriter, 100);
        }
    }
    
    setTimeout(typeWriter, 500);
}

// Log initialization
console.log('%c⚡ SyndraShell Dashboard Initialized', 
    `color: ${savedTheme === 'purple' ? '#8b5cf6' : '#3b82f6'}; 
     font-size: 16px; 
     font-weight: bold; 
     text-shadow: 0 0 10px ${savedTheme === 'purple' ? '#8b5cf6' : '#3b82f6'}`
);
console.log(`%cActive Theme: ${savedTheme.toUpperCase()} TEAM`, 
    'color: #94a3b8; font-size: 14px;'
);
