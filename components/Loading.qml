import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.0
import FileIO 1.0
import "../main.js" as Js
Item {
    id: loading
    width: 800
    height: 480
    MouseArea{
        anchors.fill: parent
        onClicked: {
            console.log("loading...")
        }
    }

    Rectangle{
        width: 200
        height: 50
        radius: 5
        border.color: "black"
        border.width: 1
        anchors{
            centerIn: parent
        }
        Image {
            source: "../icon/loading.png"
            anchors{
                top: parent.top
                left: parent.left
                bottom: parent.bottom
                right: parent.right
                topMargin: 2
                bottomMargin: 2
                leftMargin: 4
                rightMargin: 150
            }
            RotationAnimator on rotation {
                from: 0
                to: 360
                duration: 1000
                loops: Animation.Infinite
            }
        }
        Text{
            text: "Loading"
            anchors{
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: 55
            }
            font.pixelSize: 18
            Timer{
                interval: 450
                running: loading.visible
                repeat: true
                onTriggered: {
                    parent.text = parent.text + "."
                    if(parent.text === "Loading...."){
                        parent.text = "Loading"
                        loading.visible = false
                    }
                }
            }
        }
    }
}
