import QtQuick 2.12
import QtQuick.Controls 2.12
import "../main.js" as Js

Rectangle {
    id: formLogin
    width: 500
    height: 275
    color: "#ffffff"
    radius: 10
    anchors{
        bottom: parent.bottom
        horizontalCenter: parent.horizontalCenter
        bottomMargin: 25
    }
    signal clicked
    FontLoader {
        id: robotoBold
        name: "roboto bold"
        source: "../Font/Roboto-Bold.ttf"
    }
    FontLoader {
        id: robotoLight
        name: "roboto light"
        source: "../Font/Roboto-Light.ttf"
    }
    Text {
        id: tLogin
        anchors{
            top: parent.top
            left: parent.left
            topMargin: 20
            leftMargin: 25
        }
        color: "#63bc9c"
        text: "Login"
        font.family: robotoBold.name
        font.pixelSize: 24
    }

    Rectangle {
        id: line
        anchors{
            verticalCenter: tLogin.verticalCenter
            right: parent.right
            rightMargin: 25
        }
        width: 230
        height: 6
        color: "#63bc9c"
    }

    TextField {
        id: inputID
        height: 30
        anchors{
            left: parent.left
            right: parent.right
            top: parent.top
            leftMargin: 25
            rightMargin: 25
            topMargin: 70
        }
        text: ""
        font.family: robotoLight.name
        placeholderText: "Email hoặc số điện thoại"
        background: Rectangle {
            border.color: "transparent"
        }
    }

    TextField {
        id: inputPassword
        anchors{
            top: inputID.bottom
            right: parent.right
            left: parent.left
            leftMargin: 25
            rightMargin: 25
            topMargin: 10
        }
        height: 30
        text: ""
        font.family: robotoLight.name
        placeholderText: "Password"
        echoMode: TextInput.Password
        background: Rectangle {
            border.color: "transparent"
        }
    }
    Rectangle {
        id: bFormLogin
        anchors.horizontalCenter: parent.horizontalCenter
        radius: 10
        width: 40
        height: 444
        color: "#2d897e"
        rotation: 90
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#2d897e"
            }

            GradientStop {
                position: 1
                color: "#72c994"
            }
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                Js.checkLogin(inputID.text, inputPassword.text)
                formLogin.clicked()
            }
        }
        Text {
            id: tDangNhap
            anchors.centerIn: parent
            color: "#ffffff"
            text: "ĐĂNG NHẬP"
            font.bold: true
            font.family: robotoBold.name
            font.pixelSize: 15
            rotation: -90
        }
    }

    CheckBox {
        id: checkGhiNhoDangNhap
        anchors{
            top: inputPassword.bottom
            left: parent.left
            leftMargin: 25
            topMargin: 10
        }
        width: 42
        height: 37
        font.family: robotoLight.name
        Text {
            id: tGhiNhoDangNhap
            anchors{
                left: parent.right
                verticalCenter: parent.verticalCenter
                leftMargin: 10
            }

            text: "Ghi nhớ đăng nhập"
            color: "gray"
        }
        MouseArea {
            id: mGhiNhoDangNhap
            anchors.fill: parent
        }
    }
}


