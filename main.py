import sys
from pathlib import Path
from PySide6.QtWidgets import QApplication, QSplashScreen
from PySide6.QtGui import QPixmap, QIcon
from PySide6.QtCore import Qt, QTimer, QSettings, QObject, Signal, Slot, QPoint, QSize
from PySide6.QtQml import QQmlApplicationEngine

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
    settings = QSettings("marienvo", "TraceTab")
    pos = settings.value("pos", QPoint(200, 200))
    size = settings.value("size", QSize(400, 300))

    def load_and_hide_splash():
        qml_file = Path(__file__).resolve().parent / "main.qml"
        engine.load(qml_file)
        if not engine.rootObjects():
            sys.exit(-1)

        # Find the main window object
        window = engine.rootObjects()[0]

        # Apply saved settings
        window.setProperty("x", pos.x())
        window.setProperty("y", pos.y())
        window.setProperty("width", size.width())
        window.setProperty("height", size.height())

        window.closing.connect(save_settings)
        splash.hide()

    def save_settings():
        window = engine.rootObjects()[0]
        settings.setValue("pos", window.position())
        settings.setValue("size", window.size())

    # Use QTimer to wait for 1 second before loading the QML and hiding the splash
    QTimer.singleShot(1000, load_and_hide_splash)

    sys.exit(app.exec())

if __name__ == "__main__":
    main()
