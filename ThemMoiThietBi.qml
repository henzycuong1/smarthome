import QtQuick 2.0
import QtQuick.Window 2.3
import QtQuick.Controls 2.5
import "main.js" as Js

Rectangle {
    id: clickArea
    width: 100
    height: 100
    signal clicked
    color: "transparent"
    border.color: "black"
    border.width: 1
    property bool displayDeviceInput: false
    property string currentDeviceName: inputDeviceName.text
    z: 10
    MouseArea {
        anchors.fill: parent
        onClicked: {
            parent.clicked()
        }
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
            left: parent.right
            leftMargin: 10
            verticalCenter: parent.verticalCenter
        }
        TextField {
            width: 115
            id: inputDeviceName
            text: ""
            font.family: robotoLight.name
            placeholderText: "Nhập tên thiết bị"
            font.pixelSize: 14
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 5
            background: Rectangle {
                border.color: "transparent"
                color: "transparent"
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
                    Js.createDevice();
                    currentDeviceName = inputDeviceName.text;
                    Js.createDeviceList(row);
                }
            }
        }
    }
}
