#!/usr/bin/env python3
"""
Script de vérification de l'installation de l'interface provisoire
Teste tous les composants et configurations
"""

import os
import sys
from pathlib import Path

class Colors:
    GREEN = '\033[92m'
    RED = '\033[91m'
    YELLOW = '\033[93m'
    BLUE = '\033[94m'
    RESET = '\033[0m'
    BOLD = '\033[1m'

def check_mark(passed):
    return f"{Colors.GREEN}✓{Colors.RESET}" if passed else f"{Colors.RED}✗{Colors.RESET}"

def print_header(text):
    print(f"\n{Colors.BOLD}{Colors.BLUE}{'='*60}{Colors.RESET}")
    print(f"{Colors.BOLD}{Colors.BLUE}{text.center(60)}{Colors.RESET}")
    print(f"{Colors.BOLD}{Colors.BLUE}{'='*60}{Colors.RESET}\n")

def check_file(path, description):
    exists = os.path.exists(os.path.expanduser(path))
    print(f"{check_mark(exists)} {description}")
    if exists:
        print(f"   {Colors.BLUE}└─{Colors.RESET} {path}")
    else:
        print(f"   {Colors.RED}└─ Fichier manquant: {path}{Colors.RESET}")
    return exists

def check_dependency(module_name, import_statement):
    try:
        exec(import_statement)
        print(f"{check_mark(True)} {module_name}")
        return True
    except Exception as e:
        print(f"{check_mark(False)} {module_name}")
        print(f"   {Colors.RED}└─ Erreur: {e}{Colors.RESET}")
        return False

def main():
    print_header("VÉRIFICATION DE L'INTERFACE PROVISOIRE")
    
    home = os.path.expanduser("~")
    install_dir = os.path.join(home, ".config", "SyndraShell")
    
    # Vérification des fichiers principaux
    print(f"{Colors.BOLD}1. Fichiers principaux{Colors.RESET}")
    files = {
        f"{install_dir}/provisional_interface.py": "Interface principale",
        f"{install_dir}/launch-provisional.sh": "Script de lancement",
        f"{install_dir}/manage-autostart.sh": "Gestionnaire d'autostart",
        f"{install_dir}/test-provisional.py": "Script de test",
        f"{install_dir}/config/provisional_config.json": "Configuration JSON",
    }
    
    files_ok = sum(check_file(path, desc) for path, desc in files.items())
    print(f"\n{Colors.BOLD}Résultat:{Colors.RESET} {files_ok}/{len(files)} fichiers présents\n")
    
    # Vérification des raccourcis
    print(f"{Colors.BOLD}2. Raccourcis et autostart{Colors.RESET}")
    shortcuts = {
        f"{home}/.local/share/applications/syndra-provisional.desktop": "Raccourci menu applications",
        f"{home}/.config/autostart/syndra-provisional.desktop": "Autostart (optionnel)",
    }
    
    shortcuts_ok = 0
    for path, desc in shortcuts.items():
        exists = os.path.exists(path)
        if "optionnel" in desc:
            status = "activé" if exists else "désactivé"
            print(f"ℹ️  {desc}: {status}")
            shortcuts_ok += 1 if exists else 0
        else:
            check_file(path, desc)
            shortcuts_ok += 1 if exists else 0
    
    print()
    
    # Vérification des dépendances Python
    print(f"{Colors.BOLD}3. Dépendances Python{Colors.RESET}")
    dependencies = {
        "Python GTK3": "import gi; gi.require_version('Gtk', '3.0'); from gi.repository import Gtk",
        "GLib": "from gi.repository import GLib",
        "OS module": "import os",
        "JSON module": "import json",
    }
    
    deps_ok = sum(check_dependency(name, code) for name, code in dependencies.items())
    print(f"\n{Colors.BOLD}Résultat:{Colors.RESET} {deps_ok}/{len(dependencies)} dépendances disponibles\n")
    
    # Vérification des permissions
    print(f"{Colors.BOLD}4. Permissions d'exécution{Colors.RESET}")
    executables = [
        f"{install_dir}/provisional_interface.py",
        f"{install_dir}/launch-provisional.sh",
        f"{install_dir}/manage-autostart.sh",
        f"{install_dir}/test-provisional.py",
    ]
    
    perms_ok = 0
    for path in executables:
        if os.path.exists(path):
            is_exec = os.access(path, os.X_OK)
            print(f"{check_mark(is_exec)} {os.path.basename(path)}")
            if not is_exec:
                print(f"   {Colors.YELLOW}└─ Exécutez: chmod +x {path}{Colors.RESET}")
            else:
                perms_ok += 1
    
    print(f"\n{Colors.BOLD}Résultat:{Colors.RESET} {perms_ok}/{len(executables)} fichiers exécutables\n")
    
    # Vérification de la documentation
    print(f"{Colors.BOLD}5. Documentation{Colors.RESET}")
    docs = {
        f"{install_dir}/docs/PROVISIONAL-INTERFACE.md": "Documentation principale",
        f"{install_dir}/docs/PROVISIONAL-CUSTOMIZATION.md": "Guide de personnalisation",
        f"{install_dir}/docs/PROVISIONAL-CONTROL.md": "Guide de contrôle",
    }
    
    docs_ok = sum(check_file(path, desc) for path, desc in docs.items())
    print(f"\n{Colors.BOLD}Résultat:{Colors.RESET} {docs_ok}/{len(docs)} fichiers de documentation\n")
    
    # Résumé final
    print_header("RÉSUMÉ")
    
    total_checks = files_ok + shortcuts_ok + deps_ok + perms_ok + docs_ok
    max_checks = len(files) + len(shortcuts) + len(dependencies) + len(executables) + len(docs)
    percentage = (total_checks / max_checks) * 100
    
    print(f"Score global: {total_checks}/{max_checks} ({percentage:.1f}%)\n")
    
    if percentage == 100:
        print(f"{Colors.GREEN}{Colors.BOLD}✓ Installation parfaite!{Colors.RESET}")
        print("L'interface provisoire est prête à être utilisée.\n")
    elif percentage >= 80:
        print(f"{Colors.YELLOW}{Colors.BOLD}⚠ Installation bonne mais incomplète{Colors.RESET}")
        print("Certains fichiers optionnels sont manquants.\n")
    elif percentage >= 60:
        print(f"{Colors.YELLOW}{Colors.BOLD}⚠ Installation partielle{Colors.RESET}")
        print("Certains composants essentiels sont manquants.\n")
    else:
        print(f"{Colors.RED}{Colors.BOLD}✗ Installation incomplète{Colors.RESET}")
        print("De nombreux composants sont manquants. Réinstallez Syndra.\n")
    
    # Conseils
    print(f"{Colors.BOLD}Commandes utiles:{Colors.RESET}")
    print(f"  Lancer l'interface     : python {install_dir}/provisional_interface.py")
    print(f"  Gérer l'autostart      : {install_dir}/manage-autostart.sh status")
    print(f"  Voir la documentation  : cat {install_dir}/docs/PROVISIONAL-INTERFACE.md")
    print()
    
    return 0 if percentage >= 80 else 1

if __name__ == "__main__":
    try:
        sys.exit(main())
    except KeyboardInterrupt:
        print(f"\n{Colors.YELLOW}Vérification interrompue{Colors.RESET}")
        sys.exit(130)
    except Exception as e:
        print(f"\n{Colors.RED}Erreur: {e}{Colors.RESET}")
        sys.exit(1)
