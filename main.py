import sys
from pathlib import Path
from PySide6.QtWidgets import QApplication, QSplashScreen
from PySide6.QtGui import QPixmap, QIcon
from PySide6.QtCore import Qt, QTimer
from PySide6.QtQml import QQmlApplicationEngine

# Todo: remember window position?
# Todo: save and load settings from ~/Notes/todo.settings

def main():
    app = QApplication(sys.argv)
    splash = QSplashScreen(QPixmap('splash.png'), Qt.WindowStaysOnTopHint)
    splash.show()
    app.setWindowIcon(QIcon('icon.png'))
    app.setApplicationName("TraceTab")

    engine = QQmlApplicationEngine()

    def load_and_hide_splash():
        qml_file = Path(__file__).resolve().parent / "main.qml"
        engine.load(qml_file)
        if not engine.rootObjects():
            sys.exit(-1)
        splash.hide()

    # Use QTimer to wait for 1 second before loading the QML and hiding the splash
    QTimer.singleShot(1000, load_and_hide_splash)

    sys.exit(app.exec())

if __name__ == "__main__":
    main()
