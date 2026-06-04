"""
Génère une palette de couleurs Syndra à partir d'un fond d'écran.
Équivalent léger de matugen, basé sur PIL (déjà installé).
Retourne un dict de variables CSS (--shadow, --surface, --primary, ...).
"""

import colorsys
import os


def _hex(h: float, s: float, v: float) -> str:
    h = h % 1.0
    s = max(0.0, min(1.0, s))
    v = max(0.0, min(1.0, v))
    r, g, b = colorsys.hsv_to_rgb(h, s, v)
    return f"#{int(r * 255):02x}{int(g * 255):02x}{int(b * 255):02x}"


def _dominant_hsv(path: str):
    """Couleur représentative (teinte, saturation) la plus vibrante de l'image."""
    try:
        from PIL import Image
    except ImportError:
        return None
    try:
        img = Image.open(path).convert("RGB")
        img = img.resize((96, 96))
        q = img.quantize(colors=12)
        palette = q.getpalette()
        counts = q.getcolors()  # [(count, index), ...]
        if not counts:
            return None
        best = None
        for count, idx in counts:
            r, g, b = palette[idx * 3: idx * 3 + 3]
            h, s, v = colorsys.rgb_to_hsv(r / 255, g / 255, b / 255)
            if v < 0.18 or s < 0.12:
                continue  # ignore noir/blanc/gris
            score = s * (count ** 0.5) * (0.5 + v)
            if best is None or score > best[0]:
                best = (score, h, s, v)
        if best is None:
            # image très désaturée : prend la couleur la plus fréquente
            count, idx = max(counts)
            r, g, b = palette[idx * 3: idx * 3 + 3]
            h, s, v = colorsys.rgb_to_hsv(r / 255, g / 255, b / 255)
            return h, max(s, 0.15)
        return best[1], max(best[2], 0.35)
    except Exception:
        return None


def generate(path: str) -> dict:
    """Construit une palette CSS sombre cohérente avec le fond d'écran."""
    if not path or not os.path.isfile(path):
        return {}
    dom = _dominant_hsv(path)
    if dom is None:
        return {}
    h, s = dom
    sm = min(s, 0.65)  # saturation maîtrisée pour les accents

    return {
        "--foreground":      _hex(h, 0.12, 0.92),
        "--background":      _hex(h, s * 0.55, 0.05),
        "--cursor":          _hex(h, sm, 0.80),
        "--primary":         _hex(h, sm, 0.80),
        "--on-primary":      _hex(h, s * 0.55, 0.05),
        "--secondary":       _hex(h + 0.06, sm * 0.9, 0.78),
        "--on-secondary":    _hex(h, s * 0.55, 0.05),
        "--tertiary":        _hex(h - 0.06, sm * 0.9, 0.78),
        "--on-tertiary":     _hex(h, s * 0.55, 0.05),
        "--surface":         _hex(h, s * 0.45, 0.11),
        "--surface-bright":  _hex(h, s * 0.40, 0.18),
        "--surface_bright":  _hex(h, s * 0.40, 0.18),
        "--error":           "#f38ba8",
        "--error-dim":       "#d4708a",
        "--on-error":        _hex(h, s * 0.55, 0.05),
        "--error-container": "#6b1a2a",
        "--outline":         _hex(h, s * 0.35, 0.28),
        "--shadow":          _hex(h, s * 0.50, 0.055),
        "--red":     "#f38ba8", "--red-dim":     "#d4708a",
        "--green":   "#a6e3a1", "--green-dim":   "#88c584",
        "--yellow":  "#f9e2af", "--yellow-dim":  "#dbc492",
        "--blue":    _hex(0.60, sm, 0.78), "--blue-dim":    _hex(0.60, sm, 0.62),
        "--magenta": _hex(0.83, sm, 0.78), "--magenta-dim": _hex(0.83, sm, 0.62),
        "--cyan":    _hex(0.50, sm, 0.78), "--cyan-dim":    _hex(0.50, sm, 0.62),
        "--white":           _hex(h, 0.08, 0.95),
    }
