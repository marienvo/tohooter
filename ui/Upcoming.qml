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
                id: area1
                width: parent.width * 0.18
                height: 200
                color: 'lightblue'
                anchors.top: parent.top
                anchors.topMargin: 300
            }

            Rectangle {
                id: area2
                width: parent.width * 0.18
                height: 200
                color: 'lightblue'
                anchors.top: parent.top
                x: parent.width * 0.2
                anchors.topMargin: 300
            }

            Rectangle {
                id: card
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
                            card.x = Math.max(
                                0,
                                Math.min(
                                    mainArea.width - card.width,
                                    card.startX
                                )
                            );
                            card.y = Math.max(
                                0,
                                Math.min(
                                    mainArea.height - card.height,
                                    card.startY
                                )
                            );
                        }
                    }

                    onPressed: {
                        card.startPos = Qt.point(card.x, card.y);
                        card.opacity = 0.5;
                    }

                    onReleased: {
                        card.opacity = 1.0;
                        if (
                            scriptLogic.isMouseWithinTargetArea(
                                card.x + mouseX,
                                card.y + mouseY,
                                area1
                            )
                        ) {
                            console.log('Dropped in target area 1');
                        } else if (
                            scriptLogic.isMouseWithinTargetArea(
                                card.x + mouseX,
                                card.y + mouseY,
                                area2
                            )
                        ) {
                            console.log('Dropped in target area 2');
                        } else {
                            card.x = card.startPos.x;
                            card.y = card.startPos.y;
                        }
                    }
                }
            }
        }
    }
    QtObject {
        id: scriptLogic

        function isMouseWithinTargetArea(mouseX, mouseY, targetArea) {
            return (
                mouseX >= targetArea.x &&
                mouseX <= targetArea.x + targetArea.width &&
                mouseY >= targetArea.y &&
                mouseY <= targetArea.y + targetArea.height
            );
        }
    }
}
