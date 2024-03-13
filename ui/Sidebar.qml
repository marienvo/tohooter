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
            text: '📋'
            onClicked: sidebar.ribbonIconClicked('Today')
            contentItem: Text {
                text: parent.text
                color: 'white'
                anchors.centerIn: parent
            }
        }
        Button {
            text: '🕑'
            onClicked: sidebar.ribbonIconClicked('Upcoming')
            contentItem: Text {
                text: parent.text
                color: 'white'
                anchors.centerIn: parent
            }
        }
        Button {
            text: '⚙️'
            onClicked: sidebar.ribbonIconClicked('Settings')
            contentItem: Text {
                text: parent.text
                color: 'white'
                anchors.centerIn: parent
            }
        }
    }
}
