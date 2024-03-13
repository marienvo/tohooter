import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Universal 2.15

Rectangle {
    width: 60
    height: parent.height
    color: '#333'
    Universal.theme: Universal.Light

    signal ribbonIconClicked(string screen)
    signal homeClicked

    Column {
        anchors.fill: parent
        spacing: 10
        anchors.margins: 10
        Button {
            text: 'Home'
            onClicked: sidebar.ribbonIconClicked('Today')
        }
        Button {
            text: 'Settings'
            onClicked: sidebar.ribbonIconClicked('Settings')
        }
    }
}
