import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    minimumWidth: 400
    minimumHeight: 300
    color: "#f2f2f2"

    Item {
        anchors.fill: parent
        anchors.margins: 20 // Adjust the margin as needed
        Column {
            spacing: 10
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right

            Repeater {
                model: todo_manager.todoModel
                delegate: Row {
                    spacing: 10

                    Text {
                        text: display
                        color: done ? "green" : "black"
                        font.strikeout: done
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                done = !done;
                            }
                        }
                    }

                    Text {
                        text: "(From Note: " + note + ")"
                    }
                }
            }

            TextField {
                width: parent.width // Make the TextField take the full width of the Column
                placeholderText: "Enter some text..."
                // Add some padding if needed
                leftPadding: 10
                rightPadding: 10
                id: textField1
            }

            TextField {
                width: parent.width // Make the TextField take the full width of the Column
                placeholderText: "Enter note..."
                // Add some padding if needed
                leftPadding: 10
                rightPadding: 10
                id: textField2
            }

            Button {
                width: parent.width // Optional: Make the Button take the full width of the Column
                text: "Add Todo"
                onClicked: {
                    console.info(todo_manager.addTodo)
                    todo_manager.addTodo(textField1.text, textField2.text);
                    textField1.text = "";
                    textField2.text = "";
                }
            }
        }
    }
}
