"""
Tools module for SyndraShell
Provides screenshot, screen recording, OCR, and other utilities
"""
import os
from fabric.widgets.box import Box
from fabric.widgets.button import Button
from fabric.utils import exec_shell_command, exec_shell_command_async
from gi.repository import GLib

import config.data as data


class Toolbox(Box):
    """Toolbox with screenshot, recording, and utility tools"""
    
    def __init__(self, **kwargs):
        super().__init__(
            name="toolbox",
            spacing=8,
            orientation="v",
            h_expand=True,
            v_expand=True,
            **kwargs,
        )
        
        self.scripts_dir = os.path.join(os.path.dirname(os.path.dirname(__file__)), "scripts")
        self.recording = False
        
        # Screenshot section
        screenshot_label = Button(
            name="toolbox-section-label",
            label="📸 Screenshots",
            sensitive=False,
        )
        
        self.btn_ss_region = Button(
            name="toolbox-button",
            label="✂️ Region",
            tooltip_text="Capture selected region",
            on_clicked=lambda *_: self.screenshot("s"),
        )
        
        self.btn_ss_window = Button(
            name="toolbox-button",
            label="🪟 Window",
            tooltip_text="Capture focused window",
            on_clicked=lambda *_: self.screenshot("w"),
        )
        
        self.btn_ss_screen = Button(
            name="toolbox-button",
            label="🖥️ Screen",
            tooltip_text="Capture entire screen",
            on_clicked=lambda *_: self.screenshot("p"),
        )
        
        self.btn_ss_mockup = Button(
            name="toolbox-button",
            label="🎨 Mockup",
            tooltip_text="Capture region with mockup effects",
            on_clicked=lambda *_: self.screenshot("s", mockup=True),
        )
        
        screenshot_box = Box(
            orientation="h",
            spacing=4,
            children=[
                self.btn_ss_region,
                self.btn_ss_window,
                self.btn_ss_screen,
                self.btn_ss_mockup,
            ],
        )
        
        # Recording section
        recording_label = Button(
            name="toolbox-section-label",
            label="🎬 Recording",
            sensitive=False,
        )
        
        self.btn_record = Button(
            name="toolbox-button",
            label="⏺️ Record",
            tooltip_text="Start/stop screen recording",
            on_clicked=self.toggle_recording,
        )
        
        # OCR section
        ocr_label = Button(
            name="toolbox-section-label",
            label="📝 OCR",
            sensitive=False,
        )
        
        self.btn_ocr = Button(
            name="toolbox-button",
            label="🔍 Extract Text",
            tooltip_text="Capture region and extract text (OCR)",
            on_clicked=lambda *_: self.run_ocr(),
        )
        
        # Color picker section
        picker_label = Button(
            name="toolbox-section-label",
            label="🎨 Color",
            sensitive=False,
        )
        
        self.btn_color_picker = Button(
            name="toolbox-button",
            label="🎯 Pick Color",
            tooltip_text="Pick color from screen",
            on_clicked=lambda *_: self.color_picker(),
        )
        
        # Game mode section
        game_label = Button(
            name="toolbox-section-label",
            label="🎮 Performance",
            sensitive=False,
        )
        
        self.btn_gamemode = Button(
            name="toolbox-button",
            label="⚡ Game Mode",
            tooltip_text="Toggle game mode (disable effects)",
            on_clicked=lambda *_: self.toggle_gamemode(),
        )
        
        # Assemble toolbox
        self.children = [
            screenshot_label,
            screenshot_box,
            recording_label,
            self.btn_record,
            ocr_label,
            self.btn_ocr,
            picker_label,
            self.btn_color_picker,
            game_label,
            self.btn_gamemode,
        ]
    
    def screenshot(self, mode: str, mockup: bool = False):
        """
        Take screenshot
        
        Args:
            mode: Screenshot mode (s=region, w=window, p=screen)
            mockup: Apply mockup effects
        """
        script = os.path.join(self.scripts_dir, "screenshot.sh")
        
        if not os.path.exists(script):
            print(f"Error: Screenshot script not found at {script}")
            return
        
        mockup_arg = "mockup" if mockup else ""
        cmd = f'bash "{script}" {mode} {mockup_arg}'
        
        exec_shell_command_async(cmd)
        print(f"Screenshot: mode={mode}, mockup={mockup}")
    
    def toggle_recording(self, *_):
        """Toggle screen recording"""
        script = os.path.join(self.scripts_dir, "screenrecord.sh")
        
        if not os.path.exists(script):
            print(f"Error: Screen recording script not found at {script}")
            return
        
        cmd = f'bash "{script}"'
        exec_shell_command_async(cmd)
        
        self.recording = not self.recording
        
        if self.recording:
            self.btn_record.set_label("⏹️ Stop")
            print("Started recording")
        else:
            self.btn_record.set_label("⏺️ Record")
            print("Stopped recording")
    
    def run_ocr(self):
        """Run OCR on screen region"""
        script = os.path.join(self.scripts_dir, "ocr.sh")
        
        if not os.path.exists(script):
            print(f"Error: OCR script not found at {script}")
            return
        
        cmd = f'bash "{script}"'
        exec_shell_command_async(cmd)
        print("Running OCR...")
    
    def color_picker(self):
        """Launch color picker"""
        cmd = "hyprpicker -a"
        exec_shell_command_async(cmd)
        print("Color picker launched")
    
    def toggle_gamemode(self):
        """Toggle game mode"""
        script = os.path.join(self.scripts_dir, "gamemode.sh")
        
        if not os.path.exists(script):
            print(f"Error: Game mode script not found at {script}")
            return
        
        cmd = f'bash "{script}"'
        exec_shell_command_async(cmd)
        print("Toggled game mode")
