import QtQuick 2.12
import QtQuick.Controls 2.12
import "../main.js" as Js

Rectangle {
    id: messageBox
    property string newTitle
    property string newText
    property string newInfomativeText
    width: 400
    height: 110
    color: "transparent"
    anchors.centerIn: parent
    MouseArea{
        anchors.fill: parent
    }

    Rectangle{
        id: titleMessageBox
        height: 30
        anchors{
            top: parent.top
            right: parent.right
            left: parent.left
        }
        color: "black"
        Text {
            id: tTitleMessageBox
            text: newTitle
            color: "white"
            wrapMode: Text.Wrap
            anchors{
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: 10
            }
        }
    }
    Rectangle{
        id: textMessageBox
        anchors{
            bottom: parent.bottom
            right: parent.right
            left: parent.left
            top: titleMessageBox.bottom
        }
        border.color: "black"
        border.width: 1
        color: "white"
        Text {
            id: tTextMessageBox
            text: newText
            wrapMode: Text.Wrap
            anchors.centerIn: parent
            color: "black"
        }
        Rectangle{
            id: bOk
            width: 50
            height: 30
            radius: 10
            color: "black"
            anchors{
                bottom: parent.bottom
                bottomMargin: 5
                horizontalCenter: parent.horizontalCenter
            }

            Text {
                id: tBOk
                text: "OK"
                color: "white"
                anchors.centerIn: parent
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    messageBox.visible = false
                }
            }
        }
    }
}
