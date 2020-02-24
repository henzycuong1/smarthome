import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Controls 2.5
import QtQuick.Dialogs 1.2
import FileIO 1.0
import "main.js" as Js

Item {
    id: containerMenu
    width: Screen.width
    height: Screen.height
    property string fileURL
    property bool displayFormInput: false
    property string currentRoom
    property bool pressed: false
    property bool dialogPressed: false
    z: 10
    FontLoader {
        id: robotoBold
        name: "roboto bold"
        source: "Font/Roboto-Bold.ttf"
    }
    FontLoader {
        id: robotoLight
        name: "roboto light"
        source: "Font/Roboto-Light.ttf"
    }
    FontLoader {
        id: robotoRegular
        name: "roboto regular"
        source: "Font/Roboto-Regular.ttf"
    }
    FileIO {
        id: file
    }
    Rectangle {
        id: menuAdminTTB
        height: 100
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
        color: "black"
        z: 10
        Row {
            id: row
            spacing: 10
            topPadding: 25
            bottomPadding: 25
            leftPadding: 10
            Rectangle {
                id: rowChild
                width: 115
                height: 50
                x: 50
                radius: 10
                Text {
                    id: tThemThietBi
                    text: "Thêm thiết bị"
                    font.family: robotoLight.name
                    font.pointSize: 12
                    anchors.centerIn: parent
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onPressed: {
                        Js.startDrag(mouse)
                        containerMenu.pressed = true
                    }
                    onPositionChanged: {
                        containerMenu.pressed ? Js.continueDrag(mouse) : ""
                    }
                    onReleased: {
                        Js.endDrag(currentRoom)
                        containerMenu.pressed = false
                    }
                    onEntered: {
                        parent.color = "blue"
                        tThemThietBi.color = "white"
                    }
                    onExited: {
                        parent.color = "white"
                        tThemThietBi.color = "black"
                    }
                }
            }

            Rectangle {
                width: 115
                height: 50
                radius: 10
                Text {
                    id: tXoaToanBoTTB
                    text: "Xóa toàn bộ"
                    font.family: robotoLight.name
                    font.pointSize: 12
                    anchors.centerIn: parent
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        Js.clearAllItems(row, currentRoom + "Address")
                        Js.clearAllItems(row, currentRoom + "DeviceName")
                    }
                    onEntered: {
                        parent.color = "blue"
                        tXoaToanBoTTB.color = "white"
                    }
                    onExited: {
                        parent.color = "white"
                        tXoaToanBoTTB.color = "black"
                    }
                }
            }
        }
    }
    Rectangle {
        id: menuAdminTP
        anchors {
            left: parent.left
            top: parent.top
            topMargin: parent.height / 8.5
            bottom: parent.bottom
        }
        width: parent.width / 10
        color: "black"
        z: 10
        Column {
            id: column
            spacing: 10
            topPadding: 20
            leftPadding: 10
            rightPadding: 10
            Rectangle {
                width: 115
                height: 50
                radius: 10
                Text {
                    id: tThemPhong
                    text: "Thêm Phòng"
                    font.family: robotoLight.name
                    font.pointSize: 12
                    anchors.centerIn: parent
                }
                MouseArea {
                    hoverEnabled: true
                    anchors.fill: parent
                    onClicked: fileDialog.visible = true
                    onEntered: {
                        parent.color = "blue"
                        tThemPhong.color = "white"
                    }
                    onExited: {
                        parent.color = "white"
                        tThemPhong.color = "black"
                    }
                }
                FileDialog {
                    id: fileDialog
                    title: "Chọn phòng"
                    folder: shortcuts.home
                    onAccepted: {
                        containerMenu.fileURL = fileUrl
                        Js.insertImage()
                        Js.createRoomList(column, file.numberLine("temp"))
                    }
                }
            }
            Rectangle {
                width: 115
                height: 50
                radius: 10
                Text {
                    id: tXoaToanBoTB
                    text: "Xóa toàn bộ"
                    font.family: robotoLight.name
                    font.pointSize: 12
                    anchors.centerIn: parent
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        Js.clearAllItems(column, "temp")
                    }
                    onEntered: {
                        parent.color = "blue"
                        tXoaToanBoTB.color = "white"
                    }
                    onExited: {
                        parent.color = "white"
                        tXoaToanBoTB.color = "black"
                    }
                }
            }
            Component.onCompleted: {
                Js.createRoomList(column, file.numberLine("temp"))
            }
        }
    }
    Rectangle {
        id: formInputRoomName
        visible: displayFormInput
        width: 200
        height: 50
        color: "transparent"
        border.color: "black"
        border.width: 1
        radius: 10
        anchors.centerIn: containerMenu
        TextField {
            width: 115
            id: inputRoomName
            text: ""
            font.family: robotoLight.name
            placeholderText: "Nhập tên phòng"
            font.pixelSize: 14
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 5
            background: Rectangle {
                border.color: "transparent"
                color: "transparent"
            }
        }
        Rectangle {
            width: 50
            height: 40
            color: "black"
            radius: 10
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 5
            Text {
                color: "white"
                text: "OK"
                anchors.centerIn: parent
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    Js.createNewFile(inputRoomName.text)
                    currentRoom = inputRoomName.text
                    Js.createRoomList(column, file.numberLine("temp"))
                }
            }
        }
    }
    Rectangle{
        id: restart
        width: 100
        height: 50
        color: "transparent"
        border.color: "black"
        border.width: 1
        radius: 10
        anchors {
            bottom: parent.bottom
            bottomMargin: 100
            right: parent.right
            rightMargin: 100
        }

        Text {
            text: "Hoàn thành"
            anchors.centerIn: parent
        }
        MouseArea{
            anchors.fill: parent
            onClicked:{
               file.restart();
            }
        }
    }

    Component.onCompleted: {

        //        Js.createComponentWhenStartup();
    }
}
