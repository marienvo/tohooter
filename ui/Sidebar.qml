import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    width: 60
    height: parent.height
    color: '#333'

    signal settingsClicked
    signal homeClicked

    Column {
        anchors.fill: parent
        spacing: 10
        anchors.margins: 10
        Button {
            text: 'Home'
            onClicked: sidebar.homeClicked()
        }
        Button {
            text: 'Settings'
            onClicked: sidebar.settingsClicked()
        }
    }
}
