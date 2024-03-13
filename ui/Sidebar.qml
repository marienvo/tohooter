// Sidebar.qml
import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: sidebar
    width: 60 // Breedte van het zijpaneel
    height: parent.height
    color: '#333' // Achtergrondkleur van het zijpaneel

    Column {
        anchors.fill: parent
        spacing: 10
        anchors.margins: 10

        // Voorbeeldknop 1
        Button {
            text: 'Home'
            icon.source: 'qrc:/assets/icon.png'
        }
        // Voorbeeldknop 2
        Button {
            text: qsTr('Settings')
            icon: IconType.settings
            flat: true
        }
        // Voeg hier meer knoppen toe naar behoefte
    }
}
