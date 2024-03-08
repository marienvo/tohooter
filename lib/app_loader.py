import sys
from pathlib import Path

from PySide6.QtCore import QTimer, QUrl
from PySide6.QtGui import QIcon, QSurfaceFormat
from PySide6.QtQml import QQmlApplicationEngine

from lib.settings_manager import load_settings, save_settings


# Todo: set ~/Notes/todo.settings string via settings_manager, save and read rest of settings in settings file:
# Todo: save and load settings from ~/Notes/todo.settings

def app_loader(app, splash, app_name, organization_name):
    app.setWindowIcon(QIcon('icon.png'))
    app.setApplicationName(app_name)
    app.setOrganizationName(organization_name)
    app.setOrganizationDomain("marienvanoverbeek.nl")

    engine = QQmlApplicationEngine()
    pos, size = load_settings(app_name, organization_name)

    # Do all the heavy lifting
    # ...

    def open_window():
        application_path = Path(getattr(sys, '_MEIPASS', Path(__file__).resolve().parent.parent))
        qml_file = application_path / "main.qml"

        # Set the surface format before creating the application
        format = QSurfaceFormat()
        format.setSwapInterval(0)
        format.setRenderableType(QSurfaceFormat.OpenGL)
        QSurfaceFormat.setDefaultFormat(format)

        engine.load(QUrl.fromLocalFile(qml_file))

        if not engine.rootObjects():
            sys.exit(-1)

        # Find the main QML item
        item = engine.rootObjects()[0]

        # Apply saved settings
        item.setProperty("x", pos.x())
        item.setProperty("y", pos.y())
        item.setProperty("width", size.width())
        item.setProperty("height", size.height())

        # Connect the save_settings function
        item.closing.connect(lambda: save_settings(app_name, organization_name, item))
        splash.hide()

    QTimer.singleShot(1000, open_window)
