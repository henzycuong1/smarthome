import QtQuick 2.12
import QtQuick.Window 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.0
import "../main.js" as Js

Item{
    id: bell
    anchors.centerIn: parent
    Image {
        id: iconBell
        source: "../icon/bell.png"
        sourceSize.width: 200
        sourceSize.height: 200
        anchors.centerIn: parent
        MouseArea{
            anchors.fill: parent
            onClicked: {
                camera.visible = true
                console.log("bell")
            }
        }
        RotationAnimator{
            target: iconBell
            from: -35
            to: 35
            running: true
            duration: 1000
            loops: Animator.Infinite
        }
    }
    Rectangle{
        id: camera
        width: 700
        height: 400
        visible: false
        border.color: "black"
        border.width: 1
        anchors.centerIn: parent
        Rectangle{
            height: 40
            color: "black"
            anchors{
                right: parent.right
                left: parent.left
                top: parent.top
            }
            Image{
                source: "../icon/closebutton.png"
                sourceSize.width: 25
                sourceSize.height: 25
                anchors{
                    verticalCenter: parent.verticalCenter
                    right: parent.right
                    rightMargin: 10
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        camera.visible = false
                    }
                }
            }
            Text{
                text: "CAMERA"
                color: "white"
                anchors.centerIn: parent
                font.pixelSize: 20
            }
        }
        Rectangle{
            height: 360
            border.width: 1
            border.color:"black"
            anchors{
                bottom: parent.bottom
                right: parent.right
                left: parent.left
            }
        }
    }
}


