"""
Brightness Service for SyndraShell
Manages screen brightness control
"""
import subprocess
from fabric.core.service import Service, Property


class Brightness(Service):
    """Brightness control service using brightnessctl"""
    
    @Property(int, "read-write")
    def brightness(self) -> int:
        """Current brightness level (0-100)"""
        try:
            result = subprocess.run(
                ["brightnessctl", "get"],
                capture_output=True,
                text=True
            )
            current = int(result.stdout.strip())
            
            result = subprocess.run(
                ["brightnessctl", "max"],
                capture_output=True,
                text=True
            )
            max_brightness = int(result.stdout.strip())
            
            return int((current / max_brightness) * 100)
        except Exception as e:
            print(f"Error getting brightness: {e}")
            return 0
    
    @brightness.setter
    def brightness(self, value: int):
        """Set brightness level (0-100)"""
        try:
            value = max(0, min(100, value))
            subprocess.run(
                ["brightnessctl", "set", f"{value}%"],
                capture_output=True
            )
        except Exception as e:
            print(f"Error setting brightness: {e}")
