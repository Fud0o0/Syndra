// SyndraShell - Interactive Script

const savedTheme = localStorage.getItem('syndrashell-theme') || 'purple';
document.body.classList.add(`${savedTheme}-theme`);

const pills = document.querySelectorAll('.pill');

pills.forEach(pill => {
    pill.addEventListener('click', function() {
        const team = this.getAttribute('data-team');
        
        // Remove active from all
        pills.forEach(p => p.classList.remove('active'));
        
        // Add active to clicked
        this.classList.add('active');
        
        // Change theme
        document.body.className = `${team}-theme`;
        
        // Save preference
        localStorage.setItem('syndrashell-theme', team);
    });
});

console.log('%cSyndraShell', 'color: #a855f7; font-size: 20px; font-weight: bold;');
