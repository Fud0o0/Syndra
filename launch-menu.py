#!/usr/bin/env python3
"""
Lanceur rapide pour le menu Syndra
"""
import sys
import os

# Ajouter le répertoire parent au path
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from modules.launcher import main

if __name__ == "__main__":
    main()
