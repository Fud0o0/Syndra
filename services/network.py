"""
Network Service for SyndraShell
Manages network connections via NetworkManager
"""
from fabric.core.service import Service, Property, Signal
import subprocess


class NetworkClient(Service):
    """Network manager service"""
    
    @Property(bool, "read")
    def connected(self) -> bool:
        """Check if network is connected"""
        try:
            result = subprocess.run(
                ["nmcli", "networking", "connectivity"],
                capture_output=True,
                text=True
            )
            return result.stdout.strip() == "full"
        except:
            return False
    
    @Property(str, "read")
    def connection_name(self) -> str:
        """Get active connection name"""
        try:
            result = subprocess.run(
                ["nmcli", "-t", "-f", "NAME", "connection", "show", "--active"],
                capture_output=True,
                text=True
            )
            lines = result.stdout.strip().split('\n')
            return lines[0] if lines else "No connection"
        except:
            return "Unknown"
    
    def toggle_wifi(self):
        """Toggle WiFi on/off"""
        try:
            subprocess.run(["nmcli", "radio", "wifi", "toggle"])
        except Exception as e:
            print(f"Error toggling WiFi: {e}")
