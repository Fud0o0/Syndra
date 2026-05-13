const translations = {
  fr: {
    // Common
    "installation": "Installation",
    "summary": "Sommaire",
    "presentation": "Présentation",
    "integrity": "Vérification d'intégrité",
    "profiles": "Profils disponibles",
    "commands": "Commandes principales",
    "shortcuts": "Raccourcis clavier",
    "tools": "Outils intégrés",
    "uninstallation": "Désinstallation",
    
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
    
    // Documentation page content
    "doc_intro": "Syndra est un environnement Hyprland orienté cybersécurité, pensé pour des usages Red Team, Blue Team, Purple Team et CTF. Cette documentation résume l'installation, les commandes principales, les profils disponibles et les bonnes pratiques de sécurité.",
    "doc_presentation_paragraph": "Syndra combine une interface Hyprland légère avec une logique d'installation sécurisée et des outils séparés en profils. L'objectif est de fournir un environnement utilisable au quotidien sans mélanger directement le GUI et la boîte à outils offensive/défensive.",
    "doc_install_method": "La méthode recommandée consiste à cloner le dépôt puis lancer l'installateur sécurisé.",
    "Interface principale sur l'hôte avec Hyprland.": "Interface principale sur l'hôte avec Hyprland.",
    "Outils de sécurité isolés via Docker ou Podman.": "Outils de sécurité isolés via Docker ou Podman.",
    "Installation sécurisée avec contrôle d'intégrité.": "Installation sécurisée avec contrôle d'intégrité.",
    "Profils Blue, Red, Purple et Root/CTF.": "Profils Blue, Red, Purple et Root/CTF.",
    "Arch Linux pour l'installation complète du GUI.": "Arch Linux pour l'installation complète du GUI.",
    "Hyprland fonctionnel.": "Hyprland fonctionnel.",
    "Docker ou Podman pour les outils conteneurisés.": "Docker ou Podman pour les outils conteneurisés.",
    "Les artefacts peuvent être vérifiés avant installation. Le mode strict impose aussi une signature valide.": "Les artefacts peuvent être vérifiés avant installation. Le mode strict impose aussi une signature valide.",
    "La politique de signature mainteneur est décrite dans": "La politique de signature mainteneur est décrite dans",
    "La politique de signature mainteneur est décrite dans checksums/SIGNING.md.": "La politique de signature mainteneur est décrite dans checksums/SIGNING.md.",
    "Pour supprimer Syndra de la machine :": "Pour supprimer Syndra de la machine :",
    "Documentation officielle": "Documentation officielle",
    "Sommaire": "Sommaire",
    "1. Présentation": "1. Présentation",
    "Points clés": "Points clés",
    "Pré-requis": "Pré-requis",
    "2. Installation": "2. Installation",
    "Installation recommandée": "Installation recommandée",
    "Installation directe par profil": "Installation directe par profil",
    "3. Vérification d'intégrité": "3. Vérification d'intégrité",
    "Contrôle SHA256": "Contrôle SHA256",
    "Mode strict": "Mode strict",
    "4. Profils disponibles": "4. Profils disponibles",
    "Défense, monitoring, détection, analyse d'incidents.": "Défense, monitoring, détection, analyse d'incidents.",
    "Pentest, exploitation, reconnaissance, post-exploitation.": "Pentest, exploitation, reconnaissance, post-exploitation.",
    "Couverture complète Red + Blue pour les opérations mixtes.": "Couverture complète Red + Blue pour les opérations mixtes.",
    "CTF, pwn, forensics, crypto et laboratoire technique.": "CTF, pwn, forensics, crypto et laboratoire technique.",
    "5. Commandes principales": "5. Commandes principales",
    "Met à jour Syndra depuis GitHub avec vérification d'intégrité.": "Met à jour Syndra depuis GitHub avec vérification d'intégrité.",
    "Redémarre le shell sans déconnexion.": "Redémarre le shell sans déconnexion.",
    "Ouvre le menu d'applications.": "Ouvre le menu d'applications.",
    "Lance l'interface GTK provisoire.": "Lance l'interface GTK provisoire.",
    "Gère le démarrage automatique.": "Gère le démarrage automatique.",
    "Affiche la version et le hash du commit.": "Affiche la version et le hash du commit.",
    "6. Raccourcis clavier": "6. Raccourcis clavier",
    "Menu Syndra.": "Menu Syndra.",
    "Dashboard.": "Dashboard.",
    "Terminal Kitty.": "Terminal Kitty.",
    "Verrouillage de session.": "Verrouillage de session.",
    "Ferme la fenêtre courante.": "Ferme la fenêtre courante.",
    "Recharge immédiatement Syndra.": "Recharge immédiatement Syndra.",
    "7. Outils intégrés": "7. Outils intégrés",
    "Reconnaissance": "Reconnaissance",
    "Exploitation": "Exploitation",
    "Scripts personnalisés": "Scripts personnalisés",
  },
  en: {
    // Common
    "installation": "Installation",
    "summary": "Summary",
    "presentation": "Presentation",
    "integrity": "Integrity Verification",
    "profiles": "Available Profiles",
    "commands": "Main Commands",
    "shortcuts": "Keyboard Shortcuts",
    "tools": "Integrated Tools",
    "uninstallation": "Uninstallation",
    
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
    
    // Documentation page content
    "doc_intro": "Syndra is a Hyprland-focused cybersecurity environment, designed for Red Team, Blue Team, Purple Team and CTF use cases. This documentation summarizes installation, main commands, available profiles and security best practices.",
    "doc_presentation_paragraph": "Syndra combines a lightweight Hyprland interface with a secure installation flow and tools separated into profiles. The goal is to provide a daily-usable environment without mixing the GUI and offensive/defensive toolbox directly.",
    "doc_install_method": "The recommended method is to clone the repository then run the secure installer.",
    "Interface principale sur l'hôte avec Hyprland.": "Main interface on the host with Hyprland.",
    "Outils de sécurité isolés via Docker ou Podman.": "Security tools isolated through Docker or Podman.",
    "Installation sécurisée avec contrôle d'intégrité.": "Secure installation with integrity checks.",
    "Profils Blue, Red, Purple et Root/CTF.": "Blue, Red, Purple and Root/CTF profiles.",
    "Arch Linux pour l'installation complète du GUI.": "Arch Linux for full GUI installation.",
    "Hyprland fonctionnel.": "Working Hyprland setup.",
    "Docker ou Podman pour les outils conteneurisés.": "Docker or Podman for containerized tools.",
    "Les artefacts peuvent être vérifiés avant installation. Le mode strict impose aussi une signature valide.": "Artifacts can be verified before installation. Strict mode also requires a valid signature.",
    "La politique de signature mainteneur est décrite dans": "The maintainer signature policy is described in",
    "La politique de signature mainteneur est décrite dans checksums/SIGNING.md.": "The maintainer signature policy is described in checksums/SIGNING.md.",
    "Pour supprimer Syndra de la machine :": "To remove Syndra from the machine:",
    "Documentation officielle": "Official Documentation",
    "Sommaire": "Summary",
    "1. Présentation": "1. Presentation",
    "Points clés": "Key Points",
    "Pré-requis": "Prerequisites",
    "2. Installation": "2. Installation",
    "Installation recommandée": "Recommended Installation",
    "Installation directe par profil": "Direct Installation by Profile",
    "3. Vérification d'intégrité": "3. Integrity Verification",
    "Contrôle SHA256": "SHA256 Verification",
    "Mode strict": "Strict Mode",
    "4. Profils disponibles": "4. Available Profiles",
    "Défense, monitoring, détection, analyse d'incidents.": "Defense, monitoring, detection, incident analysis.",
    "Pentest, exploitation, reconnaissance, post-exploitation.": "Pentest, exploitation, reconnaissance, post-exploitation.",
    "Couverture complète Red + Blue pour les opérations mixtes.": "Complete Red + Blue coverage for mixed operations.",
    "CTF, pwn, forensics, crypto et laboratoire technique.": "CTF, pwn, forensics, crypto and technical lab.",
    "5. Commandes principales": "5. Main Commands",
    "Met à jour Syndra depuis GitHub avec vérification d'intégrité.": "Updates Syndra from GitHub with integrity verification.",
    "Redémarre le shell sans déconnexion.": "Restarts the shell without disconnection.",
    "Ouvre le menu d'applications.": "Opens the application menu.",
    "Lance l'interface GTK provisoire.": "Launches the provisional GTK interface.",
    "Gère le démarrage automatique.": "Manages autostart.",
    "Affiche la version et le hash du commit.": "Displays the version and commit hash.",
    "6. Raccourcis clavier": "6. Keyboard Shortcuts",
    "Menu Syndra.": "Syndra Menu.",
    "Dashboard.": "Dashboard.",
    "Terminal Kitty.": "Kitty Terminal.",
    "Verrouillage de session.": "Session lock.",
    "Ferme la fenêtre courante.": "Close current window.",
    "Recharge immédiatement Syndra.": "Immediately reloads Syndra.",
    "7. Outils intégrés": "7. Integrated Tools",
    "Reconnaissance": "Reconnaissance",
    "Exploitation": "Exploitation",
    "Scripts personnalisés": "Custom scripts.",
  },
  es: {
    // Common
    "installation": "Instalación",
    "summary": "Resumen",
    "presentation": "Presentación",
    "integrity": "Verificación de Integridad",
    "profiles": "Perfiles Disponibles",
    "commands": "Comandos Principales",
    "shortcuts": "Atajos de Teclado",
    "tools": "Herramientas Integradas",
    "uninstallation": "Desinstalación",
    
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
    
    // Documentation page content
    "doc_intro": "Syndra es un entorno de Hyprland orientado a la ciberseguridad, diseñado para los usos de Red Team, Blue Team, Purple Team y CTF. Esta documentación resume la instalación, los comandos principales, los perfiles disponibles y las buenas prácticas de seguridad.",
    "doc_presentation_paragraph": "Syndra combina una interfaz Hyprland ligera con un flujo de instalación seguro y herramientas separadas en perfiles. El objetivo es proporcionar un entorno utilizable a diario sin mezclar directamente la interfaz gráfica y la caja de herramientas ofensiva/defensiva.",
    "doc_install_method": "El método recomendado consiste en clonar el repositorio y luego ejecutar el instalador seguro.",
    "Interface principale sur l'hôte avec Hyprland.": "Interfaz principal en el host con Hyprland.",
    "Outils de sécurité isolés via Docker ou Podman.": "Herramientas de seguridad aisladas mediante Docker o Podman.",
    "Installation sécurisée avec contrôle d'intégrité.": "Instalación segura con verificación de integridad.",
    "Profils Blue, Red, Purple et Root/CTF.": "Perfiles Blue, Red, Purple y Root/CTF.",
    "Arch Linux pour l'installation complète du GUI.": "Arch Linux para la instalación completa de la interfaz gráfica.",
    "Hyprland fonctionnel.": "Hyprland funcional.",
    "Docker ou Podman pour les outils conteneurisés.": "Docker o Podman para herramientas en contenedores.",
    "Les artefacts peuvent être vérifiés avant installation. Le mode strict impose aussi une signature valide.": "Los artefactos pueden verificarse antes de la instalación. El modo estricto también exige una firma válida.",
    "La politique de signature mainteneur est décrite dans": "La política de firma del mantenedor se describe en",
    "La politique de signature mainteneur est décrite dans checksums/SIGNING.md.": "La política de firma del mantenedor se describe en checksums/SIGNING.md.",
    "Pour supprimer Syndra de la machine :": "Para eliminar Syndra de la máquina:",
    "Documentation officielle": "Documentación Oficial",
    "Sommaire": "Resumen",
    "1. Présentation": "1. Presentación",
    "Points clés": "Puntos clave",
    "Pré-requis": "Requisitos previos",
    "2. Installation": "2. Instalación",
    "Installation recommandée": "Instalación Recomendada",
    "Installation directe par profil": "Instalación Directa por Perfil",
    "3. Vérification d'intégrité": "3. Verificación de Integridad",
    "Contrôle SHA256": "Verificación SHA256",
    "Mode strict": "Modo Estricto",
    "4. Profils disponibles": "4. Perfiles Disponibles",
    "Défense, monitoring, détection, analyse d'incidents.": "Defensa, monitoreo, detección, análisis de incidentes.",
    "Pentest, exploitation, reconnaissance, post-exploitation.": "Pentest, explotación, reconocimiento, post-explotación.",
    "Couverture complète Red + Blue pour les opérations mixtes.": "Cobertura completa Red + Blue para operaciones mixtas.",
    "CTF, pwn, forensics, crypto et laboratoire technique.": "CTF, pwn, forensics, crypto y laboratorio técnico.",
    "5. Commandes principales": "5. Comandos Principales",
    "Met à jour Syndra depuis GitHub avec vérification d'intégrité.": "Actualiza Syndra desde GitHub con verificación de integridad.",
    "Redémarre le shell sans déconnexion.": "Reinicia el shell sin desconexión.",
    "Ouvre le menu d'applications.": "Abre el menú de aplicaciones.",
    "Lance l'interface GTK provisoire.": "Lanza la interfaz GTK provisional.",
    "Gère le démarrage automatique.": "Gestiona el inicio automático.",
    "Affiche la version et le hash du commit.": "Muestra la versión y el hash del commit.",
    "6. Raccourcis clavier": "6. Atajos de Teclado",
    "Menu Syndra.": "Menú Syndra.",
    "Dashboard.": "Panel de control.",
    "Terminal Kitty.": "Terminal Kitty.",
    "Verrouillage de session.": "Bloqueo de sesión.",
    "Ferme la fenêtre courante.": "Cierra la ventana actual.",
    "Recharge immédiatement Syndra.": "Recarga Syndra inmediatamente.",
    "7. Outils intégrés": "7. Herramientas Integradas",
    "Reconnaissance": "Reconocimiento",
    "Exploitation": "Explotación",
    "Scripts personnalisés": "Scripts personalizados.",
  }
};

// Language management - expose to window
window.currentLang = localStorage.getItem('syndraLang') || 'fr';
window.translations = translations;

function setLanguage(lang) {
  window.currentLang = lang;
  localStorage.setItem('syndraLang', lang);
  document.documentElement.lang = lang;
  translatePage();
}

function getTranslation(key) {
  return window.translations[window.currentLang]?.[key] || window.translations['fr']?.[key] || key;
}

function translatePage() {
  // Translate all elements with data-i18n attribute
  document.querySelectorAll('[data-i18n]').forEach(element => {
    const key = element.getAttribute('data-i18n');
    const translation = getTranslation(key);
    if (element.tagName === 'INPUT' && element.hasAttribute('placeholder')) {
      element.placeholder = translation;
    } else {
      element.innerHTML = translation;
    }
  });

  // Build reverse maps for all languages: normalized value -> key
  const reverseMaps = {};
  Object.keys(window.translations).forEach(lang => {
    reverseMaps[lang] = {};
    Object.keys(window.translations[lang] || {}).forEach(k => {
      const v = (window.translations[lang][k] || '').toString();
      const norm = v.trim().replace(/\s+/g, ' ').replace(/[\.:,;!\u2026]+$/g, '').toLowerCase();
      if (!norm) return;
      // prefer a canonical key (without spaces) if another key maps to the same value
      let assignedKey = k;
      const candidates = Object.keys(window.translations[lang] || {}).filter(c => c !== k && c.indexOf(' ') === -1);
      const stripped = norm.replace(/^\d+\s*[\).\-:]+\s*/,'').replace(/^\d+\.\s*/,'').trim();
      for (const c of candidates) {
        const cv = (window.translations[lang][c] || '').toString().trim().replace(/\s+/g,' ').replace(/[\.:,;!\u2026]+$/g,'').toLowerCase();
        if (cv === norm || cv === stripped) { assignedKey = c; break; }
      }
      reverseMaps[lang][norm] = assignedKey;
      // add variant without leading numbering mapped to the same assigned key
      if (stripped && stripped !== norm) reverseMaps[lang][stripped] = assignedKey;
    });
  });

  // Helper to normalize a string for lookup
  function normalizeForLookup(s) {
    return s.toString().trim().replace(/\s+/g, ' ').replace(/[\.:,;!\u2026]+$/g, '').toLowerCase();
  }

  // Translate attributes on all elements (alt, title, placeholder, aria-label)
  const ATTRS = ['alt', 'title', 'placeholder', 'aria-label'];
  document.querySelectorAll('*').forEach(el => {
    ATTRS.forEach(attr => {
      if (el.hasAttribute(attr)) {
        let raw = el.getAttribute(attr) || '';
        if (!raw.trim()) return;
        // remove numeric prefix for lookup
        const numMatch = raw.match(/^\s*(\d+\s*[\).\-:]+\s*)/);
        if (numMatch) raw = raw.replace(numMatch[1], '');
        const norm = normalizeForLookup(raw);
        let key = null;
        for (const L of Object.keys(reverseMaps)) {
          if (reverseMaps[L][norm]) { key = reverseMaps[L][norm]; break; }
        }
        if (key) {
          const translated = getTranslation(key);
          el.setAttribute(attr, translated);
        }
      }
    });
  });

  // Translate visible text nodes (skip script/style/code/pre/textarea)
  const walker = document.createTreeWalker(
    document.body,
    NodeFilter.SHOW_TEXT,
    {
      acceptNode(node) {
        const parent = node.parentElement;
        if (!parent) return NodeFilter.FILTER_REJECT;
        const skip = ['SCRIPT','STYLE','CODE','PRE','TEXTAREA','NOSCRIPT'];
        if (skip.includes(parent.tagName)) return NodeFilter.FILTER_REJECT;
        if (!node.nodeValue || !node.nodeValue.trim()) return NodeFilter.FILTER_REJECT;
        return NodeFilter.FILTER_ACCEPT;
      }
    },
    false
  );

  const textNodes = [];
  let n;
  while (n = walker.nextNode()) {
    textNodes.push(n);
  }

  // Remove isolated numeric prefix text nodes (e.g. '1. ') when the following text is translatable
  const isNumericPrefix = s => /^\s*\d+\s*[\).\-:]*\s*$/.test(s);
  for (let i = 0; i < textNodes.length; i++) {
    const node = textNodes[i];
    if (!node.nodeValue) continue;
    if (!isNumericPrefix(node.nodeValue)) continue;
    // find next non-empty text node
    let j = i + 1; let next = null;
    while (j < textNodes.length) {
      const cand = textNodes[j];
      if (cand && cand.nodeValue && cand.nodeValue.trim()) { next = cand; break; }
      j++;
    }
    if (!next) continue;
    // check if next maps to a key
    const core = next.nodeValue.trim().replace(/^[\d\s\).\-:]+/, '').replace(/[\.:,;!\u2026]+$/,'');
    const norm = normalizeForLookup(core);
    let key = null;
    for (const L of Object.keys(reverseMaps)) {
      if (reverseMaps[L][norm]) { key = reverseMaps[L][norm]; break; }
    }
    if (key) {
      node.nodeValue = '';
    }
  }

  // Replace content preserving surrounding whitespace and removing numeric prefixes
  for (let i = textNodes.length - 1; i >= 0; i--) {
    const tn = textNodes[i];
    const original = tn.nodeValue;
    const leading = original.match(/^\s*/) ? original.match(/^\s*/)[0] : '';
    const trailing = original.match(/\s*$/) ? original.match(/\s*$/)[0] : '';
    let core = original.trim();
    if (!core) continue;

    // Remove numeric prefix if present
    const numMatchCore = core.match(/^(\d+\s*[\).\-:]+\s*)/);
    if (numMatchCore) core = core.replace(numMatchCore[1], '');

    // Keep the core content for exact translation lookup
    const m = core.match(/^(.*?)([\.:,;!\u2026]+)?$/);
    const textCore = m ? m[1] : core;

    const norm = normalizeForLookup(textCore);

    // find key by checking reverse maps for any language
    let key = null;
    for (const L of Object.keys(reverseMaps)) {
      if (reverseMaps[L][norm]) { key = reverseMaps[L][norm]; break; }
    }

    // try stripped variant
    if (!key) {
      const stripped = textCore.replace(/^\d+\s*[\).\-:]+\s*/,'').replace(/^\d+\.\s*/,'').trim();
      const normStripped = normalizeForLookup(stripped);
      for (const L of Object.keys(reverseMaps)) {
        if (reverseMaps[L][normStripped]) { key = reverseMaps[L][normStripped]; break; }
      }
    }

    if (key) {
      const translatedCore = getTranslation(key) || textCore;
      tn.nodeValue = leading + translatedCore + trailing;
    }
  }

  // Update language selector
  const langSelector = document.querySelector('#language-selector');
  if (langSelector) {
    langSelector.value = window.currentLang;
  }
}

// Make functions global
window.setLanguage = setLanguage;
window.getTranslation = getTranslation;
window.translatePage = translatePage;

// Initialize on page load
document.addEventListener('DOMContentLoaded', () => {
  document.documentElement.lang = window.currentLang;
  
  // Setup language selector if it exists
  const langSelector = document.querySelector('#language-selector');
  if (langSelector) {
    langSelector.value = window.currentLang;
    langSelector.addEventListener('change', (e) => {
      setLanguage(e.target.value);
    });
  }
  
  translatePage();
});
