import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.VirtualKeyboard 2.1
import "."
import "main.js" as Js

Rectangle {
    id: formLogin
    width: 500
    height: 275
    color: "#ffffff"
    radius: 10
    signal clicked
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
    Text {
        id: tLogin
        x: 27
        y: 21
        color: "#63bc9c"
        text: qsTr("Login")
        font.family: robotoBold.name
        font.pixelSize: 24
    }

    Rectangle {
        id: rectangle
        x: 242
        y: 32
        width: 230
        height: 6
        color: "#63bc9c"
    }

    TextField {
        id: inputID
        x: 27
        y: 68
        width: 445
        height: 29
        text: qsTr("")
//        focus: Qt.inputMethod.visible;
        font.family: robotoLight.name
        placeholderText: "Email hoặc số điện thoại"
        background: Rectangle {
            border.color: "transparent"
        }
    }

    TextField {
        id: inputPassword
        x: 28
        y: 109
        width: 445
        height: 29
        text: qsTr("")
//        focus: Qt.inputMethod.visible;
        font.family: robotoLight.name
        placeholderText: "Password"
        echoMode: TextInput.Password
        background: Rectangle {
            border.color: "transparent"
        }
    }
    Button {
        id: bFormLogin
        x: 28
        y: 209
        width: 444
        height: 40
        background: Rectangle {
            radius: 10
        }
        onClicked: {
            Js.checkLogin(inputID.text, inputPassword.text)
            parent.clicked()
        }
    }

    Rectangle {
        x: 231
        y: 7
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
    }
    Text {
        id: element1
        anchors.centerIn: bFormLogin
        width: 89.35
        color: "#ffffff"
        text: qsTr("ĐĂNG NHẬP")
        font.bold: true
        font.family: robotoBold.name
        font.pixelSize: 15
    }
    Text {
        id: tQuenMatKhau
        x: 334
        y: 142
        width: 136
        height: 16
        text: qsTr("Quên mật khẩu?")
        color: "gray"
        font.pixelSize: 16
        font.family: robotoLight.name

        MouseArea {
            id: mQuenMatKhau
            anchors.fill: parent
        }
    }

    CheckBox {
        id: checkGhiNhoDangNhap
        x: 37
        y: 159
        width: 42
        height: 37
        Text {
            id: tGhiNhoDangNhap
            x: 45
            y: 9
            text: "Ghi nhớ đăng nhập"
            color: "gray"
        }
        MouseArea {
            id: mGhiNhoDangNhap
            x: 39
            y: 2
            anchors.fill: tGhiNhoDangNhap
        }
    }
    Connections {
        target: mGhiNhoDangNhap
        onClicked: print("Clicked Ghi Nho Dang Nhap")
    }

    Connections {
        target: mQuenMatKhau
        onClicked: print("Clicked Quen Mat Khau123")
    }
}


