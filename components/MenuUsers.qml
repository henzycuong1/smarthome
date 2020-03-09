import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.0
import FileIO 1.0
import "../main.js" as Js

Item {
    id: menuUsers
    height: parent.height
    width: parent.width
    signal clicked
    property bool displayMenuChangeRoom: false
    property bool displayMenuControl
    property bool childMenuUser: false
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
            bottomMargin: displayMenuControl ? 0 : -100
        }
        height: 100
        z: 10
        color: "#7accc8"
        opacity: 0.7
        radius: 10
        Behavior on anchors.bottomMargin {
            NumberAnimation { duration: 300 }
        }

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
        visible: true
        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
            leftMargin: displayMenuChangeRoom ? 0 : -120
        }
        width: 120
        z: 10
        radius: 10
        color: "#7accc8"
        opacity: 0.7
        Behavior on anchors.leftMargin {
            NumberAnimation{ duration: 300 }
        }
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
        ScrollView{
            anchors.fill: parent
            Column{
                id: columnUsers
                spacing: 10
                topPadding: 50
                leftPadding: 10
                rightPadding: 10
            }
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
            RotationAnimator on rotation{
                from: 0;
                to: 360
                duration: 2000
                loops: Animation.Infinite
            }
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
    Rectangle{
        width: 50
        height: 50
        radius: 100
        border.color: "black"
        border.width: 1
        color:"transparent"
        anchors{
            right: parent.right
            bottom: parent.bottom
            rightMargin: 10
            bottomMargin: 10
        }
        Image {
            source: "../icon/arrow.png"
            sourceSize.width: 30
            sourceSize.height: 30
            anchors.centerIn: parent
            rotation: childMenuUser ? -90 : 90
            Behavior on rotation {
                NumberAnimation { duration: 500 }
            }
        }
        MouseArea{
            anchors.fill: parent
            onClicked:{
               childMenuUser = !childMenuUser
            }
        }
        ColumnLayout{
           visible: childMenuUser
           spacing: childMenuUser ? 10 : -35
           anchors{
               horizontalCenter: parent.horizontalCenter
               bottom: parent.top
               bottomMargin: childMenuUser ? 10 : -50
           }
           Behavior on spacing {
               NumberAnimation{ duration: 500}
           }
           Behavior on anchors.bottomMargin {
               NumberAnimation {duration: 500}
           }

           Rectangle{
               width: 35
               height: 35
               radius: 100
               color: "transparent"
               border.color: "black"
               border.width: 1
               MouseArea{
                   anchors.fill: parent
                   onClicked: {
                       Js.signOut()
                   }
               }
               Text {
                   text: "Đăng xuất"
                   anchors{
                       right: parent.left
                       verticalCenter: parent.verticalCenter
                       rightMargin: 5
                   }
                   font.pixelSize: 14
               }
           }
        }
    }
}
