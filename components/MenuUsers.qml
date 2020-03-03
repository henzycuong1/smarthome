import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.2
import FileIO 1.0
import "../main.js" as Js

Item {
    id: menuUsers
    height: parent.height
    width: parent.width
    signal clicked
    property bool displayMenuChangeRoom: false
    property bool displayMenuControl
    FileIO{
        id:file
    }
    Rectangle {
        id: menuControlUsers
        visible: displayMenuControl
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        height: 100
        z: 10
        color: "#7accc8"
        opacity: 0.7
        radius: 10
        Rectangle {
            id: closeMenuControl
            anchors {
                top: parent.top
                topMargin: 10
                right: parent.right
                rightMargin: 10
            }
            width: 25
            height: 25
            z: 10
            radius: 100
            color: "transparent"
            Image {
                id: iconCloseControl
                source: "../icon/closebutton.png"
                sourceSize.height: 25
                sourceSize.width: 25
            }
            MouseArea {
                id: mCloseMenuControl
                anchors.fill: parent
                onClicked: Js.pointClicked();
            }
        }
    }
    Rectangle {
        id: menuChangeRoomUsers
        visible: displayMenuChangeRoom
        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
        }
        width: 120
        z: 10
        radius: 10
        color: "#7accc8"
        opacity: 0.7
        Rectangle {
            id: closeMenuChangeRoom
            anchors {
                top: parent.top
                topMargin: 10
                right: parent.right
                rightMargin: 10
            }
            width: 25
            height: 25
            z: 10
            color: "transparent"
            radius:100
            Image {
                id: iconCloseRoom
                source: "../icon/closebutton.png"
                sourceSize.height: 25
                sourceSize.width: 25
            }
            MouseArea {
                id: mCloseMenuChangeRoom
                anchors.fill: parent
                onClicked: {
                    displayMenuChangeRoom = false;
                    for(let i = 0; i < columnUsers.children.length; i++){
                        columnUsers.children[i].destroy()
                    }
                    bShowMenuChangeRoom.visible = true;
                }
            }
        }
        Column{
            id: columnUsers
            spacing: 10
            topPadding: 50
            leftPadding: 10
            rightPadding: 10
        }
    }
    Rectangle{
        id: bShowMenuChangeRoom
        width: 50
        height: 50
        anchors { top: parent.top; topMargin: 10; left: parent.left; leftMargin: 10 }
        color: "transparent"
        Image {
            id: iconChooseRoom
            source: "../icon/change.png"
            sourceSize.width: 50
            sourceSize.height: 50
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                displayMenuChangeRoom = true;
                bShowMenuChangeRoom.visible = false;
                Js.createRoomList(columnUsers, false);
            }
        }
    }
}
