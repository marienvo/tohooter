import sys

from PySide6.QtWidgets import QApplication, QSplashScreen
from PySide6.QtGui import QPixmap, QIcon
from PySide6.QtCore import Qt
from PySide6.QtQml import QQmlApplicationEngine

from lib.app_loader import app_loader


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

    # Call the load_and_hide_splash function
    app_loader(engine, splash, "TraceTab", "marienvo")

    sys.exit(app.exec())

if __name__ == "__main__":
    main()
