import sys
from pathlib import Path

from PySide6.QtWidgets import QApplication, QSplashScreen
from PySide6.QtGui import QPixmap, QIcon
from PySide6.QtCore import Qt, QTimer, QSettings, QPoint, QSize
from PySide6.QtQml import QQmlApplicationEngine

from lib.settings_manager import load_settings, save_settings

# Todo: save and load settings from ~/Notes/todo.settings

def main():
    app = QApplication(sys.argv)
    splash = QSplashScreen(QPixmap('splash.png'), Qt.WindowStaysOnTopHint)
    splash.show()
    app.setWindowIcon(QIcon('icon.png'))
    app.setApplicationName("TraceTab")
    app.setOrganizationName("marienvo")
    app.setOrganizationDomain("marienvanoverbeek.nl")

    engine = QQmlApplicationEngine()

    # Load settings
    pos, size = load_settings("TraceTab", "marienvo")

    def load_and_hide_splash():
        qml_file = Path(__file__).resolve().parent / "main.qml"
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
        window.closing.connect(lambda: save_settings("TraceTab", "marienvo", window))
        splash.hide()

    QTimer.singleShot(1000, load_and_hide_splash)

    sys.exit(app.exec())
if __name__ == "__main__":
    main()
