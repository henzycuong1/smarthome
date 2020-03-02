import QtQuick 2.12
import QtQuick.Controls 2.12
import "main.js" as Js
Rectangle {
    id: itemComponents
    property string roomName
    property bool anchorsVarriable
    property bool adminDel
    property int itemNumber
    property string idDel
    property string nameFileDel
    signal clicked
    width: 80
    height: 35
    radius: 10
    z: 11
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            itemComponents.clicked()
        }
        onEntered: {
            parent.color = "blue"
            adminDel ? del.visible = true : undefined
        }
        onExited: {
            parent.color = "white"
            del.visible = false
        }
    }
    Text {
        anchors.centerIn: parent
        id: tRoomName
        text: roomName
    }
    Rectangle{
        id: del
        width:80
        height: 35
        color: "black"
        visible: false
        radius: 10
        anchors{
            left: anchorsVarriable ? undefined : parent.right;
            top: anchorsVarriable ? parent.bottom : undefined;
            verticalCenter: anchorsVarriable ? undefined : parent.verticalCenter;
            horizontalCenter: anchorsVarriable ? parent.horizontalCenter : undefined;
        }
        Text {
            anchors.centerIn: parent
            text: "Xóa"
            color: "white"
        }
        MouseArea{
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {
                Js.deleteRoomOrDivice(idDel,itemNumber, nameFileDel)
            }
            onEntered: {
                parent.color = "blue"
               adminDel ? del.visible = true : undefined
            }
            onExited: {
                parent.color = "black"
                del.visible = false
            }
        }
    }
}
