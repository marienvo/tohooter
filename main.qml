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
        anchors.margins: 20
        Column {
            spacing: 10
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right


            TextField {
                width: parent.width
                placeholderText: "Enter some text..."
                leftPadding: 10
                rightPadding: 10
                id: textField1
            }

            TextField {
                width: parent.width
                placeholderText: "Enter note..."
                leftPadding: 10
                rightPadding: 10
                id: textField2
            }

            Button {
                width: parent.width // Optional: Make the Button take the full width of the Column
                text: "Add Todo"
                onClicked: {
                    todo_manager.addTodo(textField1.text, textField2.text);
                    textField1.text = "";
                    textField2.text = "";
                }
            }

            Column {
                spacing: 10
                Repeater {
                    model: todoModel
                    delegate: Row {
                        spacing: 10
                        Text {
                            text: modelData.display
                            color: "black"
                            font.strikeout: modelData.done
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    modelData.done = !modelData.done;
                                }
                            }
                        }
                        Text {
                            text: "(From Note: " + modelData.note + ")"
                        }
                    }
                }
            }
        }
    }
}
