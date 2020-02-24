import QtQuick 2.0
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0
import QtQuick.Window 2.3
import "main.js" as Js
Item {
    id: menuUsers
    height: Screen.height
    width: Screen.width
    signal clicked
    Rectangle{
        id: menuControlUsers
        anchors { left: parent.left; right: parent.right; bottom: parent.bottom }
        height: parent.height/4
        z:10
        gradient: Gradient{
            GradientStop {
                position: 0.0
                color: "#8dbffc"
            }
            GradientStop{
                position: 1.0
                color: "#5797df"
            }
        }
        Button{
            id: closeMenuControl
            anchors { top: parent.top; topMargin: 10; right: parent.right; rightMargin: 10}
            width: 25
            height: 25
            z:10
            background: Rectangle{
                radius: 100
                color: "red"
                opacity: 0.5
            }
            MouseArea{
                id: mCloseMenuControl
                anchors.fill: parent
                onClicked: Js.buttonClicked()
            }
        }
    }

    Rectangle{
        id: menuChangeRoomUsers
        anchors { left: parent.left; top: parent.top; bottom: parent.bottom; bottomMargin: parent.height/4}
        width: parent.width/10
        z: 10
        gradient: Gradient{
            GradientStop {
                position: 0.0
                color: "#5797df"
            }
            GradientStop{
                position: 1.0
                color: "#8dbffc"
            }
        }
        Button{
            id: closeMenuChangeRoom
           anchors { top: parent.top; topMargin: 10; right: parent.right; rightMargin: 10 }
            width: 25
            height: 25
            z:10
            background: Rectangle{
                radius: 100
                color: "red"
                opacity: 0.5
            }
            MouseArea{
                id: mCloseMenuChangeRoom
                anchors.fill: parent
                onClicked: Js.buttonClicked()
            }
        }
    }
}
