import QtQuick 2.9
import QtQuick.Controls 2.5
import QtQuick.Dialogs 1.2
import FileIO 1.0
import "main.js" as Js

Rectangle {
    id: menuAdminTP
    anchors { left: parent.left; top: parent.top; topMargin: parent.height/8.5; bottom: parent.bottom}
    width: parent.width/10
    color: "black"
    visible: false
    z: 9
    property string fileURL
    FontLoader{
        id: robotoBold
        name: "roboto bold"
        source: "Font/Roboto-Bold.ttf"
    }
    FontLoader{
        id: robotoLight
        name: "roboto light"
        source: "Font/Roboto-Light.ttf"
    }
    FontLoader{
        id: robotoRegular
        name: "roboto regular"
        source: "Font/Roboto-Regular.ttf"
    }
    FileIO{
        id: file
    }
    Column{
        spacing: 10
        topPadding: 20
        leftPadding: 10
        rightPadding: 10
        Rectangle{
            width: menuAdminTP.width/1.2
            height: menuAdminTP.height/10
            color: "white"
//            anchors.horizontalCenter: parent.horizontalCenter
//            anchors.top: parent.top
//            anchors.topMargin: 20
            radius: 20
            Text{
                text: "Thêm Phòng"
                font.family: robotoLight.name
                font.pointSize: 12
                color: "black"
                anchors.centerIn: parent
            }
            MouseArea{
                anchors.fill: parent
                onClicked: fileDialog.visible = true
            }
            FileDialog{
                id: fileDialog
                title: "Chọn phòng"
                folder: shortcuts.home
                onAccepted: {
                    menuAdminTP.fileURL = fileUrl;
                    Js.insertImage();
                }
            }
        }
        Rectangle{
            width: menuAdminTP.width/1.2
            height: menuAdminTP.height/10
//            anchors.bottom: parent.bottom
//            anchors.bottomMargin: 20
            color: "white"
//            anchors.horizontalCenter: parent.horizontalCenter
            radius: 20
            Text{
                text: "Xóa toàn bộ"
                font.family: robotoLight.name
                font.pointSize: 12
                color: "black"
                anchors.centerIn: parent
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {

                }
            }
        }
        Component.onCompleted: {

        }
    }
}
