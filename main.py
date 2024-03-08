import sys
from pathlib import Path
from PySide6.QtWidgets import QApplication, QSplashScreen
from PySide6.QtGui import QPixmap, QIcon
from PySide6.QtCore import Qt, QTimer
from PySide6.QtQml import QQmlApplicationEngine

def main():
    app = QApplication(sys.argv)

    app.setWindowIcon(QIcon('icon.png'))
    app.setApplicationName("TraceTab")

    splash_img = QPixmap('splash.png')
    splash = QSplashScreen(splash_img, Qt.WindowStaysOnTopHint)
    splash.show()

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
