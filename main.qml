import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.0
import QtQuick.VirtualKeyboard 2.1
import FileIO 1.0
import QtQuick.Dialogs 1.0
import "components"
import "main.js" as Js
Window {
    id: root
    visible: true
    width: 800
    height: 480
    title: qsTr("Smart Home")
    color: "blue"
    property bool mainDisplayMenuControl: false
    property bool tracking: false
    property int startX
    property int startY
    property int trackingRoom: 0
    property bool trackingAdmin: true
    signal appIsDoubleClick()
    signal appIsInactive()
    onAppIsDoubleClick: {
        mainLockScreen.opacity = 0
        lockScreenTimer.running = true
    }
    onAppIsInactive: {
        if(!trackingAdmin){
            mainLockScreen.visible = true
            mainLockScreen.opacity = 1
        }
    }
    Component.onCompleted: {
        if(mainFormLogin.isChecked){
            Js.checkLogin("asd","asd")
        }
    }
    MouseArea{
        anchors.fill: parent
        hoverEnabled: true
        onReleased: {
           tracking = false
        }
        onPositionChanged: {
            if(!tracking) return
            if((mouse.x - startX) > 200 && trackingRoom > 0 && mainFormLogin.visible === false){
                trackingRoom--
                Js.choseRoom(trackingRoom,false)
                tracking = false
            }
            if((mouse.x - startX) < -200 && trackingRoom < JSON.parse(file.readFile("data.json")).length -1 && mainFormLogin.visible === false){
                trackingRoom++
                Js.choseRoom(trackingRoom,false)
                tracking = false
            }
            if((mouse.y - startY) > 300 && mainFormLogin.visible === false ){
                mainLockScreen.visible = true
                mainLockScreen.opacity = 1
            }
            if((mouse.y - startY) < -300 && mainFormLogin.visible === false ){
                mainBell.visible = !mainBell.visible
                tracking = false
            }
        }
        onPressed: {
            tracking = true
            startX = mouse.x
            startY = mouse.y
        }
    }
    FileIO{
        id: file
    }
    Background {
        id: mainBackground
        anchors.fill: parent
        isLoginScreen: true
    }
    Room {
        id: mainRoom
    }
    FormLogin {
        id: mainFormLogin
        anchors{
            bottom: keyboard.visible ? keyboard.top : parent.bottom
            horizontalCenter: parent.horizontalCenter
            bottomMargin: keyboard.visible ? 0 : 25
        }
    }
    ListView {
        id: listPoint
    }
    MenuAdmin{
        id: mainMenuAdmin
        visible: false
        displayKeyboard: keyboard.visible
    }
    MenuUsers {
        id: mainMenuUsers
        visible: false
        displayMenuControl: mainDisplayMenuControl
    }
    MessageBox {
        id: messageBox
        visible: false
    }
    LockScreen{
        id:mainLockScreen
        visible: false
        opacity: 0
        z: 9999
       Behavior on opacity{
           NumberAnimation{duration: 2000}
       }
        Timer{
            id: lockScreenTimer
            interval: 2000
            onTriggered: {
                mainLockScreen.visible = false;
            }
        }
    }
    Bell{
        id: mainBell
        visible: false
    }
    Loading{
        id: mainLoading
        visible: false
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
