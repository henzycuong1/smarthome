import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.0
import FileIO 1.0
import "../main.js" as Js

Item {
    id: containerMenuAdmin
    width: parent.width
    height: parent.height
    property string fileURL
    property bool displayFormInput: false
    property string currentRoom
    property bool pressed: false
    property bool dialogPressed: false
    FontLoader {
        id: robotoLight
        name: "roboto light"
        source: "../Font/Roboto-Light.ttf"
    }
    FileIO {
        id: file
    }
    Component.onCompleted: {
        Js.createRoomList(column, true)
    }
    Rectangle {
        id: menuAdminAddNewDevice
        height: 50
        visible: column.children.length > 2 ? true : false
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            topMargin: containerMenuAdmin.pressed ? -50 : undefined
        }
        color: "black"
        opacity: 0.7
        Behavior on anchors.topMargin{
            NumberAnimation{ duration: 500}
        }

        Row {
            id: row
            spacing: 10
            topPadding: 7.5
            bottomPadding: 7.5
            leftPadding: 10
            Rectangle {
                width: 100
                height: 35
                x: 50
                radius: 10
                Text {
                    id: tAddNewDevice
                    text: "Thêm thiết bị"
                    font.family: robotoLight.name
                    font.pointSize: 9
                    anchors{
                        right: parent.right;
                        rightMargin: 5;
                        verticalCenter: parent.verticalCenter;
                    }
                }
                Image {
                    id: iconAddNewDevice
                    source: "../icon/add.png"
                    sourceSize.width: 15
                    sourceSize.height: 15
                    anchors{
                        left: parent.left
                        leftMargin: 5
                        verticalCenter: parent.verticalCenter
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onPressed: {
                        Js.startDrag(mouse)
                        containerMenuAdmin.pressed = true
                    }
                    onPositionChanged: {
                        containerMenuAdmin.pressed ? Js.continueDrag(mouse) : ""
                    }
                    onReleased: {
                        Js.endDrag(currentRoom)
                    }
                    onEntered: {
                        parent.color = "blue"
                        tAddNewDevice.color = "white"
                    }
                    onExited: {
                        parent.color = "white"
                        tAddNewDevice.color = "black"
                    }
                }
            }

            Rectangle {
                width: 100
                height: 35
                radius: 10
                Text {
                    id: tDeleteAllDevice
                    text: "Xóa toàn bộ"
                    font.family: robotoLight.name
                    font.pointSize: 9
                    anchors{
                        right: parent.right;
                        rightMargin: 5
                        verticalCenter: parent.verticalCenter
                    }
                }
                Image {
                    source: "../icon/trash.png"
                    sourceSize.width: 15
                    sourceSize.height: 15
                    anchors{
                        left: parent.left
                        leftMargin: 5
                        verticalCenter: parent.verticalCenter
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        Js.clearAllItems(row, currentRoom)
                    }
                    onEntered: {
                        parent.color = "blue"
                        tDeleteAllDevice.color = "white"
                    }
                    onExited: {
                        parent.color = "white"
                        tDeleteAllDevice.color = "black"
                    }
                }
            }
        }
    }
    Rectangle {
        id: menuAdminAddRoom
        anchors {
            left: parent.left
            top: parent.top
            topMargin: menuAdminAddNewDevice.visible ? 50 : undefined
            bottom: parent.bottom
            leftMargin: containerMenuAdmin.pressed ? -100 : undefined
        }
        width: 100
        color: "black"
        opacity: 0.7
        Behavior on anchors.topMargin {
            NumberAnimation { duration: 500 }
        }
        Behavior on anchors.leftMargin{
            NumberAnimation { duration: 500 }
        }
        Column {
            id: column
            spacing: 10
            topPadding: 20
            leftPadding: 10
            rightPadding: 10
            Rectangle {
                width: 80
                height: 70
                radius: 10
                Text {
                    id: tAddRoom
                    text: "Thêm Phòng"
                    font.family: robotoLight.name
                    font.pointSize: 9
                    anchors{
                        bottom: parent.bottom;
                        bottomMargin: 3;
                        horizontalCenter: parent.horizontalCenter;
                    }
                }
                Image {
                    source: "../icon/addroom.png"
                    sourceSize.width: 50
                    sourceSize.height: 45
                    anchors{
                        top: parent.top
                        topMargin: 5
                        horizontalCenter: parent.horizontalCenter
                    }
                }
                MouseArea {
                    hoverEnabled: true
                    anchors.fill: parent
                    onClicked: fileDialog.visible = true
                    onEntered: {
                        parent.color = "blue"
                        tAddRoom.color = "white"
                    }
                    onExited: {
                        parent.color = "white"
                        tAddRoom.color = "black"
                    }
                }
                FileDialog {
                    id: fileDialog
                    title: "Chọn phòng"
                    folder: shortcuts.home
                    onAccepted: {
                        containerMenuAdmin.fileURL = fileUrl
                        Js.insertImage()
                    }
                }
            }
            Rectangle {
                width: 80
                height: 70
                radius: 10
                Text {
                    id: tDeleteAllRoom
                    text: "Xóa toàn bộ"
                    font.family: robotoLight.name
                    font.pointSize: 9
                    anchors{
                        bottom: parent.bottom;
                        bottomMargin: 3;
                        horizontalCenter: parent.horizontalCenter
                    }

                }
                Image {
                    source: "../icon/trash.png"
                    sourceSize.width: 40
                    sourceSize.height: 40
                    anchors{
                        top: parent.top
                        topMargin: 5
                        horizontalCenter: parent.horizontalCenter
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        Js.clearAllItems(column, currentRoom)
                    }
                    onEntered: {
                        parent.color = "blue"
                        tDeleteAllRoom.color = "white"
                    }
                    onExited: {
                        parent.color = "white"
                        tDeleteAllRoom.color = "black"
                    }
                }
            }
        }
    }
    Rectangle {
        id: formInputRoomName
        visible: displayFormInput
        width: 400
        height: 110
        color: "transparent"
        border.color: "black"
        border.width: 1
        anchors.centerIn: containerMenuAdmin
        Rectangle{
            id: titleFormInputRoomName
            color: "black"
            height: 30
            anchors{
                top: parent.top
                right: parent.right
                left: parent.left
            }
            Text {
                text: "Nhập tên phòng"
                anchors.centerIn: parent
                font.family: robotoLight.name
                color: "white"
            }
        }
        Rectangle{
            anchors{
                top: titleFormInputRoomName.bottom
                right: parent.right
                left: parent.left
                bottom: parent.bottom
            }
            TextField {
                id: inputRoomName
                anchors{
                    verticalCenter: parent.verticalCenter
                    right: parent.right
                    left: parent.left
                    rightMargin: 75
                    leftMargin: 25
                }
                height: 35
                text: ""
                font.family: robotoLight.name
                placeholderText: "Nhập tên phòng.."
                font.pixelSize: 14
                color: "black"
                background: Rectangle {
                    border.color: "black"
                    border.width: 1
                    color: "transparent"
                    radius: 10
                }
            }
            Rectangle {
                width: 50
                height: 40
                color: "black"
                radius: 10
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 10
                Text {
                    color: "white"
                    text: "OK"
                    anchors.centerIn: parent
                    font.family: robotoLight.name
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        currentRoom = inputRoomName.text
                        Js.createNewRoom(inputRoomName.text, fileDialog.fileUrl)
                        Js.createRoomList(column, true)
                        Js.createPoint(inputRoomName.text,true)
                        for(let i = 2; i < row.children.length; i++){
                            row.children[i].destroy();
                        }
                    }
                }
            }
        }
    }
    Rectangle{
        id: restart
        width: 90
        height: 35
        color: "transparent"
        border.color: "black"
        border.width: 1
        radius: 10
        anchors {
            bottom: parent.bottom
            bottomMargin: 25
            right: parent.right
            rightMargin: 25
        }

        Text {
            text: "Hoàn thành"
            anchors.centerIn: parent
            font.family: robotoLight.name
        }
        MouseArea{
            anchors.fill: parent
            onClicked:{
                file.restart();
            }
        }
    }
    Rectangle{
        id: resets
        width: 80
        height: 35
        color: "transparent"
        border.color: "black"
        border.width: 1
        radius: 10
        anchors {
            bottom: parent.bottom
            bottomMargin: 25
            right: parent.right
            rightMargin: 125
        }

        Text {
            text: "Làm mới"
            anchors.centerIn: parent
            font.family: robotoLight.name
        }
        MouseArea{
            anchors.fill: parent
            onClicked:{
                Js.resets()
            }
        }
    }
}
