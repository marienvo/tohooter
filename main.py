import sys

from PySide6.QtWidgets import QApplication, QSplashScreen
from PySide6.QtGui import QPixmap
from PySide6.QtCore import Qt

from lib.app_loader import app_loader

def main():
    app = QApplication(sys.argv)
    splash = QSplashScreen(QPixmap('splash.png'), Qt.WindowStaysOnTopHint)
    splash.show()
    app_loader(app, splash, "Todohoot", "marienvo")
    sys.exit(app.exec())

if __name__ == "__main__":
    main()
