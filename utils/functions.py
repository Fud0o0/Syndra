"""
Utility functions for SyndraShell
"""
import subprocess
from typing import Dict, Any


class Colors:
    """ANSI color codes for terminal output"""
    RESET = "\033[0m"
    ERROR = "\033[91m"
    SUCCESS = "\033[92m"
    WARNING = "\033[93m"
    INFO = "\033[94m"
    UNDERLINE = "\033[4m"


def exec_shell_command(command: str) -> str:
    """Execute shell command and return output"""
    try:
        result = subprocess.run(
            command,
            shell=True,
            capture_output=True,
            text=True
        )
        return result.stdout.strip()
    except Exception as e:
        print(f"{Colors.ERROR}Error executing command: {e}{Colors.RESET}")
        return ""


def format_bytes(bytes_value: int) -> str:
    """Format bytes to human readable format"""
    for unit in ['B', 'KB', 'MB', 'GB', 'TB']:
        if bytes_value < 1024.0:
            return f"{bytes_value:.1f} {unit}"
        bytes_value /= 1024.0
    return f"{bytes_value:.1f} PB"


def get_relative_time(minutes: int) -> str:
    """Convert minutes to relative time string"""
    if minutes < 60:
        return f"{minutes}m"
    hours = minutes // 60
    if hours < 24:
        return f"{hours}h"
    days = hours // 24
    return f"{days}d"


def ensure_dir_exists(path: str):
    """Ensure directory exists, create if not"""
    import os
    os.makedirs(path, exist_ok=True)
