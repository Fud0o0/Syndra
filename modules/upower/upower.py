import logging

logger = logging.getLogger(__name__)

try:
    import dbus
    _DBUS_AVAILABLE = True
except ImportError:
    _DBUS_AVAILABLE = False
    logger.warning("python-dbus non disponible — batterie via UPower désactivée. Installez python-dbus.")


if _DBUS_AVAILABLE:
    class UPowerManager():
        def __init__(self):
            self.UPOWER_NAME = "org.freedesktop.UPower"
            self.UPOWER_PATH = "/org/freedesktop/UPower"
            self.DBUS_PROPERTIES = "org.freedesktop.DBus.Properties"
            self.bus = dbus.SystemBus()

        def detect_devices(self):
            upower_proxy = self.bus.get_object(self.UPOWER_NAME, self.UPOWER_PATH)
            upower_interface = dbus.Interface(upower_proxy, self.UPOWER_NAME)
            return upower_interface.EnumerateDevices()

        def get_display_device(self):
            upower_proxy = self.bus.get_object(self.UPOWER_NAME, self.UPOWER_PATH)
            upower_interface = dbus.Interface(upower_proxy, self.UPOWER_NAME)
            return upower_interface.GetDisplayDevice()

        def get_critical_action(self):
            upower_proxy = self.bus.get_object(self.UPOWER_NAME, self.UPOWER_PATH)
            upower_interface = dbus.Interface(upower_proxy, self.UPOWER_NAME)
            return upower_interface.GetCriticalAction()

        def get_device_percentage(self, battery):
            battery_proxy = self.bus.get_object(self.UPOWER_NAME, battery)
            battery_proxy_interface = dbus.Interface(battery_proxy, self.DBUS_PROPERTIES)
            return battery_proxy_interface.Get(self.UPOWER_NAME + ".Device", "Percentage")

        def get_full_device_information(self, battery):
            battery_proxy = self.bus.get_object(self.UPOWER_NAME, battery)
            battery_proxy_interface = dbus.Interface(battery_proxy, self.DBUS_PROPERTIES)
            all_properties = battery_proxy_interface.GetAll(self.UPOWER_NAME + ".Device")
            return {
                'HasHistory': all_properties.get('HasHistory', False),
                'HasStatistics': all_properties.get('HasStatistics', False),
                'IsPresent': all_properties.get('IsPresent', False),
                'IsRechargeable': all_properties.get('IsRechargeable', False),
                'Online': all_properties.get('Online', False),
                'PowerSupply': all_properties.get('PowerSupply', False),
                'Capacity': all_properties.get('Capacity', 0.0),
                'Energy': all_properties.get('Energy', 0.0),
                'EnergyEmpty': all_properties.get('EnergyEmpty', 0.0),
                'EnergyFull': all_properties.get('EnergyFull', 0.0),
                'EnergyFullDesign': all_properties.get('EnergyFullDesign', 0.0),
                'EnergyRate': all_properties.get('EnergyRate', 0.0),
                'Luminosity': all_properties.get('Luminosity', 0.0),
                'Percentage': all_properties.get('Percentage', 0.0),
                'Temperature': all_properties.get('Temperature', 0.0),
                'Voltage': all_properties.get('Voltage', 0.0),
                'TimeToEmpty': all_properties.get('TimeToEmpty', 0),
                'TimeToFull': all_properties.get('TimeToFull', 0),
                'IconName': all_properties.get('IconName', ''),
                'Model': all_properties.get('Model', ''),
                'NativePath': all_properties.get('NativePath', ''),
                'Serial': all_properties.get('Serial', ''),
                'Vendor': all_properties.get('Vendor', ''),
                'State': all_properties.get('State', 0),
                'Technology': all_properties.get('Technology', 0),
                'Type': all_properties.get('Type', 0),
                'WarningLevel': all_properties.get('WarningLevel', 0),
                'UpdateTime': all_properties.get('UpdateTime', 0),
            }

        def is_lid_present(self):
            upower_proxy = self.bus.get_object(self.UPOWER_NAME, self.UPOWER_PATH)
            upower_interface = dbus.Interface(upower_proxy, self.DBUS_PROPERTIES)
            return bool(upower_interface.Get(self.UPOWER_NAME, 'LidIsPresent'))

        def is_lid_closed(self):
            upower_proxy = self.bus.get_object(self.UPOWER_NAME, self.UPOWER_PATH)
            upower_interface = dbus.Interface(upower_proxy, self.DBUS_PROPERTIES)
            return bool(upower_interface.Get(self.UPOWER_NAME, 'LidIsClosed'))

        def on_battery(self):
            upower_proxy = self.bus.get_object(self.UPOWER_NAME, self.UPOWER_PATH)
            upower_interface = dbus.Interface(upower_proxy, self.DBUS_PROPERTIES)
            return bool(upower_interface.Get(self.UPOWER_NAME, 'OnBattery'))

        def has_wakeup_capabilities(self):
            upower_proxy = self.bus.get_object(self.UPOWER_NAME, self.UPOWER_PATH + "/Wakeups")
            upower_interface = dbus.Interface(upower_proxy, self.DBUS_PROPERTIES)
            return bool(upower_interface.Get(self.UPOWER_NAME + '.Wakeups', 'HasCapability'))

        def get_wakeups_data(self):
            upower_proxy = self.bus.get_object(self.UPOWER_NAME, self.UPOWER_PATH + "/Wakeups")
            upower_interface = dbus.Interface(upower_proxy, self.UPOWER_NAME + '.Wakeups')
            return upower_interface.GetData()

        def get_wakeups_total(self):
            upower_proxy = self.bus.get_object(self.UPOWER_NAME, self.UPOWER_PATH + "/Wakeups")
            upower_interface = dbus.Interface(upower_proxy, self.UPOWER_NAME + '.Wakeups')
            return upower_interface.GetTotal()

        def is_loading(self, battery):
            battery_proxy = self.bus.get_object(self.UPOWER_NAME, battery)
            battery_proxy_interface = dbus.Interface(battery_proxy, self.DBUS_PROPERTIES)
            state = int(battery_proxy_interface.Get(self.UPOWER_NAME + ".Device", "State"))
            return state == 1

        def get_state(self, battery):
            battery_proxy = self.bus.get_object(self.UPOWER_NAME, battery)
            battery_proxy_interface = dbus.Interface(battery_proxy, self.DBUS_PROPERTIES)
            state = int(battery_proxy_interface.Get(self.UPOWER_NAME + ".Device", "State"))
            states = {0: "Unknown", 1: "Loading", 2: "Discharging", 3: "Empty",
                      4: "Fully charged", 5: "Pending charge", 6: "Pending discharge"}
            return states.get(state, "Unknown")

else:
    class UPowerManager():
        def __init__(self): pass
        def detect_devices(self): return []
        def get_display_device(self): return None
        def get_critical_action(self): return None
        def get_device_percentage(self, battery): return 0.0
        def get_full_device_information(self, battery): return {}
        def is_lid_present(self): return False
        def is_lid_closed(self): return False
        def on_battery(self): return False
        def has_wakeup_capabilities(self): return False
        def get_wakeups_data(self): return []
        def get_wakeups_total(self): return 0
        def is_loading(self, battery): return False
        def get_state(self, battery): return "Unknown"
