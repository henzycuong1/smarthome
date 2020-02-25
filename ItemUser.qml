import QtQuick 2.0
import QtQuick.Controls 2.5
import "main.js" as Js
Rectangle {
    property string fileURL
    signal clicked
    id: itemUser
    width: 85
    height: 85
    radius: 10
    color: "transparent"
    border.color: "white"
    border.width: 2
    Image {
        id: imageItemUser
        source: fileURL
        sourceSize.height: 83
        sourceSize.width: 83
        anchors.centerIn: parent
    }
    MouseArea{
        anchors.fill: parent
        onClicked: {
            parent.clicked()
        }
    }
}
