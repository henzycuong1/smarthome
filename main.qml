import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Controls 2.5
import FileIO 1.0
import QtQuick.Dialogs 1.2
import "."
import "main.js" as Js
Window {
    id: root
    visible: true
    width: screen.width
    height: screen.height
    title: qsTr("Smart Home")
    color: "blue"
    property bool toggleDisplay: false
    property bool hideDisplay: true
    property string fileURLMain
    Component.onCompleted: {
    }
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
    Background{
        id: maBackground
        anchors.fill: parent
    }
    FileIO{
        id: file
    }
    FormLogin{
        id: maFormLogin
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 50
    }
    Room{
        imageURL: fileURLMain
    }
    ListView{
        id: listPoint
    }
    MenuAdminTTB{
        id: maMenuAdminTTB
        visible: false
    }
    MenuUsers{
        id: maMenuUsers
        visible: toggleDisplay
    }

}
