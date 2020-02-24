import QtQuick 2.0
import QtQuick.Controls 2.5
import "main.js" as Js
Rectangle {
    id: itemComponents
    property string roomName
    signal clicked
    width: 115
    height: 50
    radius: 10
    z:11
    MouseArea{
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            itemComponents.clicked();
        }
        onEntered: {
            parent.color = "blue"
        }
        onExited: {
            parent.color = "white"
        }
    }
    Text{
        anchors.centerIn: parent
        id: tRoomName
        text: roomName
    }
}
