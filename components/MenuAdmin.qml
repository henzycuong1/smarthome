import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.0
import QtQuick.Layouts 1.4
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
    property bool clickedMenu: false
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
        width: 50
        height: 50
        color: "black"
        radius: 100
        anchors{
            right: parent.right
            bottom: parent.bottom
            rightMargin: 50
            bottomMargin: 50
        }
        Image {
            source: "../icon/arrow.png"
            anchors.centerIn: parent
            sourceSize.width: 30
            sourceSize.height: 30
            rotation: clickedMenu ? -90 : 90
            Behavior on rotation {
                NumberAnimation{
                    duration: 500
                }
            }
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                clickedMenu = !clickedMenu
            }
        }
        ColumnLayout{
            visible: clickedMenu
            anchors{
                bottom: parent.top
                bottomMargin: 10
                horizontalCenter: parent.horizontalCenter
            }
            spacing: clickedMenu ? 10 : -35
            Behavior on spacing{
                NumberAnimation { duration: 500 }
            }
            Rectangle{
                id: resets
                width: 40
                height: 40
                color: "transparent"
                border.color: "black"
                border.width: 1
                radius: 100
                Text {
                    text: "Làm mới"
                    anchors{
                        right: parent.left
                        rightMargin: 10
                        verticalCenter: parent.verticalCenter
                    }

                    font.family: robotoLight.name
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        Js.resets()
                    }
                }
            }
            Rectangle{
                id: restart
                width: 40
                height: 40
                color: "transparent"
                border.color: "black"
                border.width: 1
                radius: 100
                Text {
                    text: "Hoàn thành"
                    anchors{
                        right: parent.left
                        rightMargin: 10
                        verticalCenter: parent.verticalCenter
                    }

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
                width: 40
                height: 40
                border.color: "black"
                radius: 100
                color: "transparent"
                border.width: 1
                Text {
                    text: "Đổi mật khẩu admin"
                    anchors{
                        right: parent.left
                        rightMargin: 10
                        verticalCenter: parent.verticalCenter
                    }

                    font.family: robotoLight.name
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        menuChangePassword.visible = !menuChangePassword.visible
                        clickedMenu = false
                    }
                }
            }
        }
    }
    Rectangle{
        id: menuChangePassword
        width: 400
        height: 250
        border.color: "black"
        color: "white"
        border.width: 1
        visible: false
        anchors.centerIn: parent
        Rectangle{
            id: titleMenuChangePassword
            anchors{
                top:parent.top
                right:parent.right
                left: parent.left
            }
            height: 50
            color: "black"
            Text{
                text: "Đổi mật khẩu"
                anchors.centerIn: parent
                color: "white"
                font.family: robotoLight.name
            }
            Image {
                source: "../icon/closebutton.png"
                sourceSize.width: 20
                sourceSize.height: 20
                anchors{
                    right: parent.right
                    rightMargin: 10
                    verticalCenter: parent.verticalCenter
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        menuChangePassword.visible = false
                    }
                }
            }
        }
        Rectangle{
            anchors{
                bottom: parent.bottom
                right: parent.right
                left: parent.left
                top: titleMenuChangePassword.bottom
            }
            TextField{
                id: oldPassword
                echoMode: TextInput.Password
                anchors{
                    left: parent.left
                    right: parent.right
                    leftMargin: 25
                    rightMargin: 25
                    top: parent.top
                    topMargin: 25
                }
                placeholderText: "Nhập mật khẩu hiện tại"
            }
            TextField{
                id: newPassword
                echoMode: TextInput.Password
                anchors{
                    left: parent.left
                    right: parent.right
                    leftMargin: 25
                    rightMargin: 25
                    top: parent.top
                    topMargin: 75
                }
                placeholderText: "Nhập mật khẩu mới"
            }
            TextField{
                id: checkNewPassword
                echoMode: TextInput.Password
                anchors{
                    left: parent.left
                    right: parent.right
                    leftMargin: 25
                    rightMargin: 25
                    top: parent.top
                    topMargin: 125
                }
                placeholderText: "Nhập lại mật khẩu mới"
            }
            Rectangle{
                width: 50
                height: 25
                color: "black"
                radius: 5
                anchors{
                    right: parent.horizontalCenter
                    rightMargin: 5
                    bottom: parent.bottom
                    bottomMargin: 5
                }

                Text {
                    text: "Xác nhận"
                    color: "white"
                    anchors.centerIn: parent
                    font.family: robotoLight.name
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        Js.changePassword(oldPassword.text,newPassword.text,checkNewPassword.text)
                        menuChangePassword.visible = false
                        Js.showMessage("Xác nhận", "Đổi mật khẩu thành công")
                    }
                }
            }
            Rectangle{
                width: 50
                height: 25
                color: "black"
                radius: 5
                anchors{
                    left: parent.horizontalCenter
                    leftMargin: 5
                    bottom: parent.bottom
                    bottomMargin: 5
                }

                Text {
                    text: "Hủy bỏ"
                    color: "white"
                    anchors.centerIn: parent
                    font.family: robotoLight.name
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked:{
                        menuChangePassword.visible = false
                        oldPassword.text = ""
                        newPassword.text = ""
                        checkNewPassword.text = ""
                    }
                }
            }
        }
    }
}
