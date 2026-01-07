// SyndraShell - Minimal Interactive Script

// Initialize theme from localStorage or default to purple
const savedTheme = localStorage.getItem('syndrashell-theme') || 'purple';
document.body.classList.add(`${savedTheme}-theme`);

// Set active pill
document.querySelector(`[data-team="${savedTheme}"]`)?.classList.add('active');

// Get team pills
const teamPills = document.querySelectorAll('.team-pill');

// Add click event listeners to team pills
teamPills.forEach(pill => {
    pill.addEventListener('click', function() {
        const selectedTeam = this.getAttribute('data-team');
        switchTheme(selectedTeam);
    });
});

// Function to switch theme
function switchTheme(team) {
    // Remove existing theme classes and active states
    document.body.classList.remove('red-theme', 'blue-theme', 'purple-theme');
    teamPills.forEach(pill => pill.classList.remove('active'));
    
    // Add new theme class
    document.body.classList.add(`${team}-theme`);
    
    // Set active pill
    document.querySelector(`[data-team="${team}"]`)?.classList.add('active');
    
    // Save theme preference
    localStorage.setItem('syndrashell-theme', team);
    
    // Add subtle effect
    createRipple(team);
}

// Create ripple effect when switching themes
function createRipple(team) {
    const colors = {
        red: '#ef4444',
        blue: '#3b82f6',
        purple: '#a855f7'
    };
    
    const ripple = document.createElement('div');
    ripple.style.cssText = `
        position: fixed;
        top: 50%;
        left: 50%;
        width: 10px;
        height: 10px;
        border-radius: 50%;
        background: ${colors[team]};
        transform: translate(-50%, -50%) scale(0);
        opacity: 0.3;
        pointer-events: none;
        z-index: 9999;
        animation: ripple 0.6s ease-out;
    `;
    
    document.body.appendChild(ripple);
    
    setTimeout(() => ripple.remove(), 600);
}

// Add CSS animation for ripple
const style = document.createElement('style');
style.textContent = `
    @keyframes ripple {
        to {
            transform: translate(-50%, -50%) scale(200);
            opacity: 0;
        }
    }
`;
document.head.appendChild(style);

// Log initialization
console.log(`%c⚡ SyndraShell`, 
    'color: #a855f7; font-size: 24px; font-weight: bold;'
);
console.log(`%cActive Theme: ${savedTheme.toUpperCase()} TEAM`, 
    'color: #a3a3a3; font-size: 14px;'
);
