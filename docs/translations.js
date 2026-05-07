const translations = {
  fr: {
    // Index page
    "tagline": "Pour les équipes Red, Blue et Purple",
    "description": "Créé par <mark>Fud0o0</mark> & <mark>Ax0-0</mark> — <mark>Syndra</mark> est une configuration Hyprland personnalisée avec des outils de sécurité intégrés.",
    "description2": "Tout ce dont vous avez besoin pour les tests de pénétration, la défense ou les défis CTF. Rapide, dépendances minimales, complètement personnalisable.",
    "quickInstall": "Installation rapide",
    "requiresArch": "Nécessite Arch Linux avec Hyprland",
    "includesProvisional": "Inclut l'interface provisoire et le lanceur d'applications",
    "openDocumentation": "Ouvrir la documentation",
    "redTeam": "Équipe Red",
    "blueTeam": "Équipe Blue",
    "purpleTeam": "Équipe Purple",
    "rootMe": "Root Me",
    "custom": "Personnalisé",
    "uninstall": "Pour désinstaller:",
    "diskSpace": "25 GB requis",
    "supportKofi": "Soutenir sur Ko-fi",
    "joinDiscord": "Rejoindre la communauté Discord",
    
    // Features section
    "features": "Fonctionnalités",
    "lightweight": "Léger",
    "lightweightDesc": "Hyprland est réactif. Tout réagit instantanément. Pas de bloat.",
    "toolsIncluded": "Outils inclus",
    "toolsIncludedDesc": "Nmap, Burp, Metasploit, Wireshark, et plus. Choisissez votre profil (Red/Blue/Purple/CTF).",
    "pickColors": "Choisissez vos couleurs",
    "pickColorsDesc": "Rouge, Bleu ou Violet. Changez de thème sans redémarrer. Fonds d'écran inclus.",
    "oneCommand": "Installation en une commande",
    "oneCommandDesc": "Clonez, exécutez, c'est fait. Les dépendances sont gérées. Fonctionne sur Arch avec Hyprland.",
  },
  en: {
    // Index page
    "tagline": "For Red, Blue & Purple Teams",
    "description": "Made by <mark>Fud0o0</mark> & <mark>Ax0-0</mark> — <mark>Syndra</mark> is a customized Hyprland setup with integrated security tools.",
    "description2": "Everything you need for penetration testing, defense, or CTF challenges. Fast, minimal dependencies, fully themeable.",
    "quickInstall": "Quick Install",
    "requiresArch": "Requires Arch Linux with Hyprland",
    "includesProvisional": "Includes provisional interface & app launcher",
    "openDocumentation": "Open Documentation",
    "redTeam": "Red Team",
    "blueTeam": "Blue Team",
    "purpleTeam": "Purple Team",
    "rootMe": "Root Me",
    "custom": "Custom",
    "uninstall": "To uninstall:",
    "diskSpace": "25 GB required",
    "supportKofi": "Support on Ko-fi",
    "joinDiscord": "Join Discord Community",
    
    // Features section
    "features": "Features",
    "lightweight": "Lightweight",
    "lightweightDesc": "Hyprland is snappy. Everything responds instantly. No bloat.",
    "toolsIncluded": "Tools Included",
    "toolsIncludedDesc": "Nmap, Burp, Metasploit, Wireshark, and more. Choose your profile (Red/Blue/Purple/CTF).",
    "pickColors": "Pick Your Colors",
    "pickColorsDesc": "Red, Blue, or Purple. Switch themes without restarting. Wallpapers included.",
    "oneCommand": "One Command Install",
    "oneCommandDesc": "Clone, run, done. Dependencies handled. Works on Arch with Hyprland.",
  },
  es: {
    // Index page
    "tagline": "Para equipos Red, Blue y Purple",
    "description": "Hecho por <mark>Fud0o0</mark> & <mark>Ax0-0</mark> — <mark>Syndra</mark> es una configuración personalizada de Hyprland con herramientas de seguridad integradas.",
    "description2": "Todo lo que necesitas para pruebas de penetración, defensa o desafíos CTF. Rápido, dependencias mínimas, completamente personalizable.",
    "quickInstall": "Instalación rápida",
    "requiresArch": "Requiere Arch Linux con Hyprland",
    "includesProvisional": "Incluye interfaz provisional y lanzador de aplicaciones",
    "openDocumentation": "Abrir documentación",
    "redTeam": "Equipo Red",
    "blueTeam": "Equipo Blue",
    "purpleTeam": "Equipo Purple",
    "rootMe": "Root Me",
    "custom": "Personalizado",
    "uninstall": "Para desinstalar:",
    "diskSpace": "Se requieren 25 GB",
    "supportKofi": "Apoyar en Ko-fi",
    "joinDiscord": "Únete a la comunidad Discord",
    
    // Features section
    "features": "Características",
    "lightweight": "Ligero",
    "lightweightDesc": "Hyprland es rápido. Todo responde instantáneamente. Sin bloat.",
    "toolsIncluded": "Herramientas incluidas",
    "toolsIncludedDesc": "Nmap, Burp, Metasploit, Wireshark, y más. Elige tu perfil (Red/Blue/Purple/CTF).",
    "pickColors": "Elige tus colores",
    "pickColorsDesc": "Rojo, Azul o Púrpura. Cambia temas sin reiniciar. Fondos de pantalla incluidos.",
    "oneCommand": "Instalación en un comando",
    "oneCommandDesc": "Clona, ejecuta, listo. Dependencias manejadas. Funciona en Arch con Hyprland.",
  }
};

// Language management
let currentLang = localStorage.getItem('syndraLang') || 'fr';

function setLanguage(lang) {
  currentLang = lang;
  localStorage.setItem('syndraLang', lang);
  document.documentElement.lang = lang;
  translatePage();
}

function getTranslation(key) {
  return translations[currentLang]?.[key] || translations['fr']?.[key] || key;
}

function translatePage() {
  // Translate all elements with data-i18n attribute
  document.querySelectorAll('[data-i18n]').forEach(element => {
    const key = element.getAttribute('data-i18n');
    const translation = getTranslation(key);
    if (element.tagName === 'INPUT' && element.type === 'placeholder') {
      element.placeholder = translation;
    } else {
      element.innerHTML = translation;
    }
  });

  // Update language selector
  const langSelector = document.querySelector('#language-selector');
  if (langSelector) {
    langSelector.value = currentLang;
  }
}

// Initialize on page load
document.addEventListener('DOMContentLoaded', () => {
  document.documentElement.lang = currentLang;
  
  // Setup language selector if it exists
  const langSelector = document.querySelector('#language-selector');
  if (langSelector) {
    langSelector.value = currentLang;
    langSelector.addEventListener('change', (e) => {
      setLanguage(e.target.value);
    });
  }
  
  translatePage();
});
