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

            property int numCols: 5
            property int gapWidth: 20

            property real colWidth: (parent.width - (numCols - 1) * gapWidth) /
                numCols

            Rectangle {
                id: area1
                // width: parent.width * 0.2 - 20
                width: mainArea.colWidth
                x: 0
                height: 200
                color: 'lightblue'
                anchors.top: parent.top
                anchors.topMargin: 300
            }

            Rectangle {
                id: area2
                width: mainArea.colWidth
                x: 1 * (mainArea.colWidth + mainArea.gapWidth)
                height: 200
                color: 'lightblue'
                anchors.top: parent.top
                anchors.topMargin: 300
            }

            Rectangle {
                id: area3
                width: mainArea.colWidth
                x: 2 * (mainArea.colWidth + mainArea.gapWidth)
                height: 200
                color: 'lightblue'
                anchors.top: parent.top
                anchors.topMargin: 300
            }

            Rectangle {
                id: area4
                width: mainArea.colWidth
                x: 3 * (mainArea.colWidth + mainArea.gapWidth)
                height: 200
                color: 'lightblue'
                anchors.top: parent.top
                anchors.topMargin: 300
            }

            Rectangle {
                id: area5
                width: mainArea.colWidth
                x: 4 * (mainArea.colWidth + mainArea.gapWidth)
                height: 200
                color: 'lightblue'
                anchors.top: parent.top
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
                        var targetAreas = [area1, area2, area3, area4, area5];
                        var droppedInTargetArea = false;

                        for (var i = 0; i < targetAreas.length; i++) {
                            if (
                                scriptLogic.isMouseWithinTargetArea(
                                    card.x + mouseX,
                                    card.y + mouseY,
                                    targetAreas[i]
                                )
                            ) {
                                console.log(
                                    'Dropped in target area ' + (i + 1)
                                );
                                droppedInTargetArea = true;
                                break;
                            }
                        }

                        if (!droppedInTargetArea) {
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
