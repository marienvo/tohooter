import sys
from pathlib import Path

from PySide6.QtCore import QTimer
from PySide6.QtGui import  QIcon
from PySide6.QtQml import QQmlApplicationEngine
from lib.settings_manager import load_settings, save_settings

# Todo: save and load settings from ~/Notes/todo.settings

def app_loader(app, splash, app_name, organization_name):
    app.setWindowIcon(QIcon('icon.png'))
    app.setApplicationName(app_name)
    app.setOrganizationName(organization_name)
    app.setOrganizationDomain("marienvanoverbeek.nl")

    engine = QQmlApplicationEngine()
    pos, size = load_settings(app_name, organization_name)

    def load_and_hide():
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

    QTimer.singleShot(1000, load_and_hide)
