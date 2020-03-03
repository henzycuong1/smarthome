import QtQuick 2.12
import QtQuick.Window 2.0
import QtQuick.Controls 2.12
import "../main.js" as Js

Rectangle {
    id: clickArea
    width: 100
    height: 100
    signal clicked
    color: "transparent"
    border.color: hoverItem ? "yellow" : "black"
    border.width: 1
    property bool displayDeviceInput: false
    property string currentDeviceName: inputDeviceName.text
    property int code
    property bool hoverItem: false
    property bool leftInput: false
    property bool rightInput: false
    MouseArea {
        anchors.fill: parent
        onClicked: {
            parent.clicked()
            Js.dislayButton(clickArea.code)
        }
    }
    OpacityAnimator{
        target: clickArea
        from:1
        to: 0
        duration: 30000
        running: hoverItem ? true : false
        loops: Animation.Infinite
    }

    Text {
        id: nameDivice
        text: ""
        color: "black"
        anchors.centerIn: parent
    }
    Rectangle {
        id: formInputDeviceName
        visible: displayDeviceInput
        width: 200
        height: 50
        color: "transparent"
        border.color: "black"
        border.width: 1
        radius: 10
        anchors {
            left: leftInput ? parent.right : undefined
            right: rightInput ? parent.left : undefined
            leftMargin: leftInput ? 10 : undefined
            rightMargin: rightInput ? 10 : undefined
            verticalCenter: parent.verticalCenter
        }
        ComboBox{
            id: inputDiviceName
            width: 120
            model: ["Đèn", "Quạt", "Tivi", "Điềuhòa"]
            onActivated: {
                currentDeviceName = currentText
            }
            anchors{
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: 5
            }

            Component.onCompleted: currentDeviceName = currentText
            background: Rectangle{
                color:"white"
                radius: 10
                height: 30
            }
        }

        Rectangle {
            width: 50
            height: 40
            color: "black"
            radius: 10
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 5
            Text {
                color: "white"
                text: "OK"
                anchors.centerIn: parent
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    Js.createDevice(inputDiviceName.currentIndex);
                    Js.createDeviceList();
                }
            }
        }
    }
}
