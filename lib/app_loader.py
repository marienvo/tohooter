import sys
from pathlib import Path

from PySide6.QtCore import QTimer
from lib.settings_manager import load_settings, save_settings

def app_loader(engine, splash, app_name, organization_name):
    pos, size = load_settings(app_name, organization_name)

    def internal_load_and_hide():
        qml_file = Path(__file__).resolve().parent / "../main.qml"
        engine.load(qml_file)
        if not engine.rootObjects():
            sys.exit(-1)

        # Find the main window object and apply saved settings
        window = engine.rootObjects()[0]
        window.setProperty("x", pos.x())
        window.setProperty("y", pos.y())
        window.setProperty("width", size.width())
        window.setProperty("height", size.height())

        # Connect the save_settings function
        window.closing.connect(lambda: save_settings(app_name, organization_name, window))
        splash.hide()

    QTimer.singleShot(1000, internal_load_and_hide)
