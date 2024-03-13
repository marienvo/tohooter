import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    minimumWidth: 400
    minimumHeight: 300
    color: '#f2f2f2'
    Material.theme: Material.Light

    onClosing: {
        // todo: somehow make the app keep running in the background for showing notifications?
        console.log('Close button pressed, but window will not close.');
    }

    Sidebar {
        // Properties indien nodig
    }

    Today {
        // Properties indien nodig
    }
}
