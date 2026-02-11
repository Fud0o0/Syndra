#!/usr/bin/env python3
"""
Syndra Themes Configuration
Système de thèmes dynamiques pour les interfaces
"""

THEMES = {
    "iceland": {
        "name": "Iceland",
        "description": "Thème glacier avec tons bleus froids",
        "icon": "❄️",
        "colors": {
            "primary": "#0288d1",
            "secondary": "#0277bd",
            "accent": "#4fc3f7",
            "background": "#e1f5fe",
            "surface": "#ffffff",
            "text": "#01579b",
            "text_secondary": "#0277bd",
            "border": "#81d4fa",
            "shadow": "rgba(2, 136, 209, 0.3)",
            "gradient_start": "#e1f5fe",
            "gradient_end": "#b3e5fc"
        }
    },
    "tokyo_night": {
        "name": "Tokyo Night",
        "description": "Thème sombre inspiré de Tokyo la nuit",
        "icon": "🌃",
        "colors": {
            "primary": "#7aa2f7",
            "secondary": "#bb9af7",
            "accent": "#7dcfff",
            "background": "#1a1b26",
            "surface": "#24283b",
            "text": "#c0caf5",
            "text_secondary": "#a9b1d6",
            "border": "#414868",
            "shadow": "rgba(122, 162, 247, 0.3)",
            "gradient_start": "#7aa2f7",
            "gradient_end": "#bb9af7"
        }
    },
    "sunset": {
        "name": "Sunset",
        "description": "Thème chaud avec tons orangés",
        "icon": "🌅",
        "colors": {
            "primary": "#ff6f00",
            "secondary": "#f57c00",
            "accent": "#ffab40",
            "background": "#fff3e0",
            "surface": "#ffffff",
            "text": "#bf360c",
            "text_secondary": "#e64a19",
            "border": "#ffcc80",
            "shadow": "rgba(255, 111, 0, 0.3)",
            "gradient_start": "#ffe0b2",
            "gradient_end": "#ffccbc"
        }
    },
    "forest": {
        "name": "Forest",
        "description": "Thème naturel avec tons verts",
        "icon": "🌲",
        "colors": {
            "primary": "#2e7d32",
            "secondary": "#388e3c",
            "accent": "#66bb6a",
            "background": "#e8f5e9",
            "surface": "#ffffff",
            "text": "#1b5e20",
            "text_secondary": "#2e7d32",
            "border": "#a5d6a7",
            "shadow": "rgba(46, 125, 50, 0.3)",
            "gradient_start": "#e8f5e9",
            "gradient_end": "#c8e6c9"
        }
    },
    "purple_haze": {
        "name": "Purple Haze",
        "description": "Thème mystique avec tons violets",
        "icon": "🔮",
        "colors": {
            "primary": "#7b1fa2",
            "secondary": "#8e24aa",
            "accent": "#ba68c8",
            "background": "#f3e5f5",
            "surface": "#ffffff",
            "text": "#4a148c",
            "text_secondary": "#6a1b9a",
            "border": "#ce93d8",
            "shadow": "rgba(123, 31, 162, 0.3)",
            "gradient_start": "#f3e5f5",
            "gradient_end": "#e1bee7"
        }
    },
    "cyberpunk": {
        "name": "Cyberpunk",
        "description": "Thème futuriste néon rose et cyan",
        "icon": "🤖",
        "colors": {
            "primary": "#ff0080",
            "secondary": "#00ffff",
            "accent": "#ffff00",
            "background": "#0a0e27",
            "surface": "#1a1d3a",
            "text": "#ffffff",
            "text_secondary": "#b4b8d4",
            "border": "#ff0080",
            "shadow": "rgba(255, 0, 128, 0.5)",
            "gradient_start": "#ff0080",
            "gradient_end": "#00ffff"
        }
    }
}

def get_theme_css(theme_name="iceland"):
    """
    Génère le CSS pour un thème donné
    
    Args:
        theme_name: Nom du thème (iceland, tokyo_night, sunset, forest, purple_haze, cyberpunk)
    
    Returns:
        str: Code CSS formaté pour le thème
    """
    if theme_name not in THEMES:
        theme_name = "iceland"
    
    theme = THEMES[theme_name]
    colors = theme["colors"]
    
    css = f"""
    window {{
        background: linear-gradient(180deg, {colors['gradient_start']} 0%, {colors['gradient_end']} 100%);
        border: 3px solid {colors['primary']};
        border-radius: 15px;
    }}
    
    .header {{
        background: linear-gradient(135deg, {colors['primary']} 0%, {colors['secondary']} 100%);
        padding: 15px;
        border-radius: 12px 12px 0 0;
        box-shadow: 0 4px 10px rgba(0,0,0,0.3);
    }}
    
    .logo-text {{
        color: white;
        font-size: 28px;
        font-weight: bold;
        text-shadow: 2px 2px 6px rgba(0,0,0,0.4);
    }}
    
    .close-button {{
        background-color: #ef5350;
        color: white;
        border: none;
        border-radius: 50%;
        min-width: 36px;
        min-height: 36px;
        font-size: 18px;
        font-weight: bold;
        box-shadow: 0 2px 6px rgba(0,0,0,0.3);
    }}
    
    .close-button:hover {{
        background-color: #f44336;
        box-shadow: 0 4px 10px rgba(244, 67, 54, 0.5);
    }}
    
    .search-entry {{
        background-color: {colors['surface']};
        color: {colors['text']};
        border: 2px solid {colors['accent']};
        border-radius: 10px;
        padding: 12px;
        font-size: 14px;
    }}
    
    .search-entry:focus {{
        border-color: {colors['primary']};
        box-shadow: 0 0 12px {colors['shadow']};
    }}
    
    button {{
        background: linear-gradient(180deg, {colors['surface']} 0%, {colors['gradient_start']} 100%);
        color: {colors['text']};
        border: 2px solid {colors['border']};
        border-radius: 8px;
        padding: 8px 16px;
        font-weight: 500;
    }}
    
    button:hover {{
        background: linear-gradient(180deg, {colors['gradient_start']} 0%, {colors['gradient_end']} 100%);
        box-shadow: 0 2px 8px {colors['shadow']};
    }}
    
    entry {{
        background-color: {colors['surface']};
        color: {colors['text']};
        border: 2px solid {colors['border']};
        border-radius: 6px;
        padding: 8px;
    }}
    
    entry:focus {{
        border-color: {colors['primary']};
        box-shadow: 0 0 8px {colors['shadow']};
    }}
    
    notebook {{
        background-color: rgba(255, 255, 255, 0.9);
        border-radius: 8px;
        padding: 10px;
    }}
    
    notebook tab {{
        background: linear-gradient(180deg, {colors['accent']} 0%, {colors['border']} 100%);
        color: {colors['text']};
        border-radius: 8px 8px 0 0;
        padding: 10px 20px;
        margin: 2px;
    }}
    
    notebook tab:checked {{
        background: linear-gradient(180deg, {colors['primary']} 0%, {colors['secondary']} 100%);
        color: white;
        font-weight: bold;
    }}
    
    .category-label {{
        color: {colors['text']};
        font-size: 16px;
        font-weight: bold;
        padding: 10px;
        text-shadow: 1px 1px 2px {colors['shadow']};
    }}
    
    .app-name {{
        color: {colors['text']};
        font-size: 12px;
        font-weight: 500;
    }}
    
    .app-button {{
        background: linear-gradient(180deg, {colors['surface']} 0%, {colors['gradient_start']} 100%);
        border: 2px solid {colors['border']};
        border-radius: 10px;
        padding: 15px;
        margin: 5px;
    }}
    
    .app-button:hover {{
        background: linear-gradient(180deg, {colors['gradient_start']} 0%, {colors['gradient_end']} 100%);
        border-color: {colors['primary']};
        box-shadow: 0 4px 12px {colors['shadow']};
    }}
    """
    
    return css

def list_themes():
    """Liste tous les thèmes disponibles"""
    return {name: {"name": theme["name"], "icon": theme["icon"], "description": theme["description"]} 
            for name, theme in THEMES.items()}

if __name__ == "__main__":
    # Test du module
    print("🎨 Thèmes disponibles:")
    print()
    for theme_id, theme in THEMES.items():
        print(f"{theme['icon']} {theme['name']}")
        print(f"   ID: {theme_id}")
        print(f"   {theme['description']}")
        print()
