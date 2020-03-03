import QtQuick 2.12
import QtQuick.Controls 2.12
import "../main.js" as Js
Rectangle {
    id: itemComponents
    property string currentName
    property bool anchorsVarriable
    property bool adminDel
    property int itemNumber
    property string idDel
    property string nameFileDel
    property string fileURL
    signal clicked
    width: adminDel ? 80 : 85
    height: adminDel ? 35 : 85
    radius: 10
    color: adminDel ? "white" : "transparent"
    border.color: adminDel ? "transparent" : "white"
    border.width: adminDel ? 0 : 2
    z: 11
    MouseArea {
        visible: adminDel ? true : false
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
        visible: adminDel ? true : false
        anchors.centerIn: parent
        id: tRoomName
        text: currentName
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
    Image {
        visible: adminDel ? false : true
        id: imageItemUser
        source: fileURL
        sourceSize.height: 83
        sourceSize.width: 83
        anchors.centerIn: parent
    }
    MouseArea{
        visible: adminDel ? false : true
        anchors.fill: parent
        onClicked: {
            parent.clicked()
        }
    }
}
