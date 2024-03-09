import sys

from PySide6.QtWidgets import QApplication
from lib.app_loader import app_loader
from lib.splash import create_splash

def main():
    app = QApplication(sys.argv)
    splash = create_splash()
    splash.show()

    # Load the main application
    app_loader(app, splash, "Tohooter", "marienvo")
    sys.exit(app.exec())

if __name__ == "__main__":
    main()
