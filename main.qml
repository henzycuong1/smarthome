import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.0
import QtQuick.VirtualKeyboard 2.1
import FileIO 1.0
import QtQuick.Dialogs 1.0
import "."
import "main.js" as Js
Window {
    id: root
    visible: true
    width: 800
    height: 480
    title: qsTr("Smart Home")
    color: "blue"
    property bool toggleDisplay: false
    property bool hideDisplay: true
    property string fileURLMain
    property variant admin
    property bool maDisplayMenuControl: false
    property int opacityLockScreenFrom
    property int opacityLockScreenTo
    MouseArea{
        anchors.fill: parent
        hoverEnabled: true
        onReleased: {
           textTimer.running = true
            console.log("main.qml -> nhả phím của mouse")
        }
        onExited: {
            textTimer.running = true
            console.log("main.qml - > rời khỏi khu vực")
        }
        onPositionChanged: {
//            textTimer.running = true
            console.log("main.qml -> mouse đang di chuyển")
        }
        onPressed: {
            textTimer.running = false
            console.log("main.qml -> nhấp phím của mouse")
        }
    }
    Timer{
        id: textTimer
        interval: 150000
        onTriggered: {
            maLockScreen.visible = true
            opacityLockScreenFrom = 0
            opacityLockScreenTo = 1
            lockScreenAnimation.running = true
        }
    }

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
    Background {
        id: maBackground
        anchors.fill: parent
        tSmartHomeVisiable: true
    }
    FileIO {
        id: file
    }
    FormLogin {
        id: maFormLogin
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50
        visible: true
    }
    Room {
        imageURL: fileURLMain
    }
    ListView {
        id: listPoint
    }
    MenuAdminTTB {
        id: maMenuAdminTTB
        visible: false
    }
    MenuUsers {
        id: maMenuUsers
        visible: false
        displayMenuControl: maDisplayMenuControl
    }
    MessageBox {
        id: messageBox
        visible: false
    }
    ButtonControl{
        id: maButtonControl
        visible: maDisplayMenuControl
    }
    LockScreen{
        id:maLockScreen
        visible: false
        opacity: 0
        z: 9999
        onDoubleClicked: {
            maLockScreen.opacity = 1
            opacityLockScreenFrom = 1
            opacityLockScreenTo = 0
            lockScreenAnimation.running = true
            lockScreenTimer.running = true
        }
        OpacityAnimator {
            id: lockScreenAnimation
            target: maLockScreen;
            from: opacityLockScreenFrom;
            to: opacityLockScreenTo;
            duration: 2000
        }
        Timer{
            id: lockScreenTimer
            interval: 2000
            onTriggered: {
                maLockScreen.visible = false;
                maLockScreen.opacity = 1;
            }
        }
    }
    InputPanel{
        id: keyboard
        visible: active
        z: 100
        anchors{
            bottom: parent.bottom
            right: parent.right
            left:parent.left
        }
    }
}
