import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Controls 2.5
import QtQuick.Dialogs 1.2
import FileIO 1.0
import "main.js" as Js

Item {
    id: menuUsers
    height: Screen.height
    width: Screen.width
    signal clicked
    property bool displayMenuChangeRoom: false
    property bool displayMenuControl
    Rectangle {
        id: menuControlUsers
        visible: displayMenuControl
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        height: parent.height / 4
        z: 10
        gradient: Gradient {
            GradientStop {
                position: 0.0
                color: "#8dbffc"
            }
            GradientStop {
                position: 1.0
                color: "#5797df"
            }
        }
        Button {
            id: closeMenuControl
            anchors {
                top: parent.top
                topMargin: 10
                right: parent.right
                rightMargin: 100
            }
            width: 25
            height: 25
            z: 10
            background: Rectangle {
                radius: 100
                color: "red"
                opacity: 0.5
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
        width: parent.width / 10
        z: 10
        gradient: Gradient {
            GradientStop {
                position: 0.0
                color: "#5797df"
            }
            GradientStop {
                position: 1.0
                color: "#8dbffc"
            }
        }
        Button {
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
            background: Rectangle {
                radius: 100
                color: "red"
                opacity: 0.5
            }
            MouseArea {
                id: mCloseMenuChangeRoom
                anchors.fill: parent
                onClicked: {
                    displayMenuChangeRoom = false;
                    for(let i = 0; i < columnUsers.children.length; i++){
                        columnUsers.children[i].destroy()
                    }
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
        width: 100
        height: 30
        anchors { top: parent.top; topMargin: 30; left: parent.left; leftMargin: 30 }
        color: "transparent"
        border.color: "black"
        border.width: 1
        Text{
            anchors.centerIn: parent
            text: "Chọn phòng"
            color: "black"
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                displayMenuChangeRoom = true;
                Js.createRoomList(columnUsers,file.numberLine("temp"));
            }
        }
    }
}
