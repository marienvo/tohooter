import logging
import sys
from pathlib import Path

from PySide6.QtCore import QTimer, QUrl, QObject, Slot, Signal
from PySide6.QtGui import QIcon, QSurfaceFormat
from PySide6.QtQml import QQmlApplicationEngine

from lib.settings_manager import load_settings, save_settings

logging.basicConfig(level=logging.INFO)  # Set logging level to INFO

# Todo: set ~/Notes/todo.settings string via settings_manager, save and read rest of settings in settings file:
# Todo: save and load settings from ~/Notes/todo.settings


class TodoManager(QObject):
    todoModelChanged = Signal(name="modelsChanged")

    def __init__(self):
        super().__init__()
        self._todoModel = [{'display': "Initial item", 'done': False, "note":'sdfdf'}]

    @property
    def todoModel(self):
        return self._todoModel

    @todoModel.setter
    def todoModel(self, value):
        self._todoModel = value

    @Slot(str, str)
    def addTodo(self, display_text, note_text):
        logging.info('Want to add: '+display_text+' '+ note_text)
        self._todoModel.append({"display": display_text, "done": False, "note": note_text})
        self.todoModel = self._todoModel
        self.todoModelChanged.emit()
        logging.info(self.todoModel[1])




def app_loader(app, splash, app_name, organization_name):
    app.setWindowIcon(QIcon('icon.png'))
    app.setApplicationName(app_name)
    app.setOrganizationName(organization_name)
    app.setOrganizationDomain("marienvanoverbeek.nl")


    engine = QQmlApplicationEngine()


    # Define the open_window function
    def open_window():
        pos, size = load_settings(app_name, organization_name)
        application_path = Path(getattr(sys, '_MEIPASS', Path(__file__).resolve().parent.parent))
        qml_file = application_path / "main.qml"
        todo_manager = TodoManager()

        @Slot()
        def updateTodoModelContext():
            engine.rootContext().setContextProperty("todoModel", todo_manager.todoModel)
        @Slot()
        def updateAddTodoContext():
            engine.rootContext().setContextProperty("addTodo", todo_manager.addTodo)

        todo_manager.todoModelChanged.connect(updateTodoModelContext)
        todo_manager.todoModelChanged.connect(updateAddTodoContext)

        engine.rootContext().setContextProperty("todo_manager", todo_manager)
        engine.rootContext().setContextProperty("addTodo", todo_manager.addTodo) # FIXME: not sure why this is needed
        engine.rootContext().setContextProperty("todoModel", todo_manager.todoModel)

        engine.load(QUrl.fromLocalFile(qml_file))

        # Set the surface format before creating the application
        format = QSurfaceFormat()
        format.setSwapInterval(0)
        format.setRenderableType(QSurfaceFormat.OpenGL)
        QSurfaceFormat.setDefaultFormat(format)

        if not engine.rootObjects():
            sys.exit(-1)

        # Find the main QML item
        item = engine.rootObjects()[0]

        # Apply saved settings
        if pos is not None:
            item.setProperty("x", pos.x())
            item.setProperty("y", pos.y())
        item.setProperty("width", size.width())
        item.setProperty("height", size.height())

        # Connect the save_settings function
        item.closing.connect(lambda: save_settings(app_name, organization_name, item))
        splash.hide()

    QTimer.singleShot(10, open_window)