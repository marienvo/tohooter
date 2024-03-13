import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Universal 2.15

Item {
    anchors.fill: parent
    anchors.leftMargin: sidebar.width + 20
    anchors.margins: 20
    Universal.theme: Universal.Light
    Column {
        spacing: 10
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        TextField {
            width: parent.width
            placeholderText: 'Enter some text...'
            leftPadding: 10
            rightPadding: 10
            id: textField1
        }

        TextField {
            width: parent.width
            placeholderText: 'Enter note...'
            leftPadding: 10
            rightPadding: 10
            id: textField2
        }

        Button {
            width: parent.width
            text: 'Add Todo'
            onClicked: {
                todo_manager.addTodo(textField1.text, textField2.text);
                textField1.text = '';
                textField2.text = '';
            }
        }

        Button {
            width: parent.width
            text: 'Exit app'
            onClicked: todo_manager.close_app()
        }

        Column {
            spacing: 10
            Repeater {
                model: todoModel
                delegate: Row {
                    spacing: 10
                    Text {
                        text: modelData.display
                        color: 'black'
                        font.strikeout: modelData.done
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                modelData.done = !modelData.done;
                            }
                        }
                    }
                    Text {
                        text: '(From Note: ' + modelData.note + ')'
                    }
                }
            }
        }
        Item {
            Rectangle {
                id: mainArea
                anchors.fill: parent
                color: 'white'

                Rectangle {
                    id: targetArea
                    width: 200
                    height: 200
                    color: 'lightblue'
                    anchors.top: parent.top
                    anchors.topMargin: 300
                }

                Rectangle {
                    id: draggable
                    width: 100
                    height: 100
                    color: 'red'
                    x: 10
                    y: 10
                    property point startPos

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        drag.target: parent

                        onPositionChanged: {
                            if (mouseArea.drag.active) {
                                var deltaX =
                                    mouseArea.mouseX - mouseArea.width / 2;
                                var deltaY =
                                    mouseArea.mouseY - mouseArea.height / 2;
                                draggable.x = Math.max(
                                    0,
                                    Math.min(
                                        mainArea.width - draggable.width,
                                        draggable.startX + deltaX
                                    )
                                );
                                draggable.y = Math.max(
                                    0,
                                    Math.min(
                                        mainArea.height - draggable.height,
                                        draggable.startY + deltaY
                                    )
                                );
                            }
                        }

                        onPressed: {
                            draggable.startPos = Qt.point(
                                draggable.x,
                                draggable.y
                            );
                            draggable.opacity = 0.5;
                        }

                        onReleased: {
                            draggable.opacity = 1.0;
                            // Check if dropped in target area
                            if (
                                draggable.x >= targetArea.x &&
                                draggable.x + draggable.width <=
                                    targetArea.x + targetArea.width &&
                                draggable.y >= targetArea.y &&
                                draggable.y + draggable.height <=
                                    targetArea.y + targetArea.height
                            ) {
                                console.log('Dropped in target area');
                                // Optionally, reset position within the target area or perform other actions
                            } else {
                                // Reset position if not dropped on target area
                                draggable.x = draggable.startPos.x;
                                draggable.y = draggable.startPos.y;
                            }
                        }
                    }
                }
            }
        }
    }
}
