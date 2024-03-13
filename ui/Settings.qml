import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

Rectangle {
    width: 400
    height: 300
    color: 'lightgray'
    Material.theme: Material.Light
    anchors.fill: parent
    anchors.leftMargin: sidebar.width + 20
    anchors.margins: 20
}
