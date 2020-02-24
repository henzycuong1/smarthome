import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Controls 2.5
import FileIO 1.0
import "main.js" as Js
Image {
    id: imageBackground
    anchors.fill: parent
    property string imageURL
//    property string nameRoom: inputRoomName.text
//    property bool displayFormInput: true
    source: imageURL
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
    z:-1
    FileIO{
        id:file
    }

//    Rectangle{
//        id: formInputRoomName
//        visible: displayFormInput
//        width: 200
//        height: 50
//        color: "transparent"
//        border.color: "black"
//        border.width: 1
//        radius: 10
//        anchors.centerIn: parent
//        TextField{
//            width: 100
//            id: inputRoomName
//            text: ""
//            font.family: robotoLight.name
//            placeholderText: "Nhập tên phòng"
//            font.pixelSize: 14
//            anchors.verticalCenter: parent.verticalCenter
//            anchors.left: parent.left
//            anchors.leftMargin: 5
//            background: Rectangle{
//                border.color: "transparent"
//                color: "transparent"
//            }
//        }
//        Rectangle{
//            width: 50
//            height: 40
//            color: "black"
//            radius: 10
//            anchors.verticalCenter: parent.verticalCenter
//            anchors.right: parent.right
//            anchors.rightMargin: 5
//            Text{
//                color: "white"
//                text: "OK"
//                anchors.centerIn: parent
//            }
//            MouseArea{
//                anchors.fill: parent
//                onClicked: {
//                    Js.createNewFile();
//                }
//            }
//        }
//    }
}
