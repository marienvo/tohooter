import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    minimumWidth: 400
    minimumHeight: 300
    color: "#ff0000"

    Item {
        anchors.fill: parent
        anchors.margins: 20 // Adjust the margin as needed
        Column {
            spacing: 10
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right

            TextField {
                width: parent.width // Make the TextField take the full width of the Column
                placeholderText: "Enter some text TEST..."
                // Add some padding if needed
                leftPadding: 10
                rightPadding: 10
                id: textField1
            }

            TextField {
                width: parent.width // Make the TextField take the full width of the Column
                placeholderText: "Enter more text..."
                // Add some padding if needed
                leftPadding: 10
                rightPadding: 10
                id: textField2
            }

            Button {
                width: parent.width // Optional: Make the Button take the full width of the Column
                text: "Click me"
                onClicked: {
                    console.log("TextField1 says:", textField1.text)
                    console.log("TextField2 says:", textField2.text)
                }
            }
        }
    }
}
