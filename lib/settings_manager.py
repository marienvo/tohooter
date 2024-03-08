from PySide6.QtCore import QSettings, QPoint, QSize

def load_settings(app_name, organization_name):
    settings = QSettings(organization_name, app_name)
    pos = settings.value("pos")
    size = settings.value("size", QSize(400, 300))
    return pos, size

def save_settings(app_name, organization_name, window):
    settings = QSettings(organization_name, app_name)
    settings.setValue("pos", window.position())
    settings.setValue("size", window.size())
