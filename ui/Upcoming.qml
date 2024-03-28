import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

Rectangle {
    width: 400
    height: 300
    color: 'blue'
    Material.theme: Material.Light
    anchors.fill: parent
    anchors.leftMargin: sidebar.width + 20
    anchors.margins: 20

    Item {
        width: parent.width
        Rectangle {
            id: mainArea
            anchors.fill: parent
            color: 'white'
            width: parent.width

            Rectangle {
                id: targetArea1
                width: parent.width * 0.18
                height: 200
                color: 'lightblue'
                anchors.top: parent.top
                anchors.topMargin: 300
            }

            Rectangle {
                id: targetArea2
                width: parent.width * 0.18
                height: 200
                color: 'lightblue'
                anchors.top: parent.top
                x: parent.width * 0.2
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
                            var deltaX = mouseArea.mouseX - mouseArea.width / 2;
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
                        draggable.startPos = Qt.point(draggable.x, draggable.y);
                        draggable.opacity = 0.5;
                    }

                    onReleased: {
                        draggable.opacity = 1.0;
                        if (
                            draggable.x >= targetArea1.x &&
                            draggable.x + draggable.width <=
                                targetArea1.x + targetArea1.width &&
                            draggable.y >= targetArea1.y &&
                            draggable.y + draggable.height <=
                                targetArea1.y + targetArea1.height
                        ) {
                            console.log('Dropped in target area 1');
                        } else if (
                            draggable.x >= targetArea2.x &&
                            draggable.x + draggable.width <=
                                targetArea2.x + targetArea2.width &&
                            draggable.y >= targetArea2.y &&
                            draggable.y + draggable.height <=
                                targetArea2.y + targetArea2.height
                        ) {
                            console.log('Dropped in target area 2');
                        } else {
                            draggable.x = draggable.startPos.x;
                            draggable.y = draggable.startPos.y;
                        }
                    }
                }
            }
        }
    }
}
