import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.0
import QtQuick.VirtualKeyboard 2.1
import FileIO 1.0
import QtQuick.Dialogs 1.0
import QtQuick.Controls.Styles 1.4
import "components"
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
    property bool mainDisplayMenuControl: false
    property int opacityLockScreenFrom
    property int opacityLockScreenTo
    property bool tracking: false
    property int startX
    property int startY
    property int trackingRoom:0
    Component.onCompleted: {
        if(mainFormLogin.isChecked){
            Js.checkLogin("asd","asd")
        }
    }
    MouseArea{
        anchors.fill: parent
        hoverEnabled: true
        onReleased: {
           textTimer.running = true
           tracking = false
        }
        onExited: {
            textTimer.running = true
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
        }
        onPressed: {
            textTimer.running = false
//            console.log("main.qml -> nhấp phím của mouse")
            tracking = true
            startX = mouse.x
            startY = mouse.y
        }
    }
    Timer{
        id: textTimer
        interval: 150000
        onTriggered: {
            mainLockScreen.visible = true
            mainLockScreen.opacity = 1
        }
    }
    FileIO{
        id:file
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
    }
    ListView {
        id: listPoint
    }
    MenuAdmin{
        id: mainMenuAdmin
        visible: false
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
        onDoubleClicked: {
            this.opacity = 0
            lockScreenTimer.running = true
        }
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
