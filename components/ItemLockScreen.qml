import QtQuick 2.12
import QtQuick.Controls 2.12
import FileIO 1.0
import QtQuick.Layouts 1.0
import "../main.js" as Js

Rectangle {
    id: itemLockScreen
    property string roomName
    property int temperature
    property int humidity
    property string roomImage
    property int deviceWorking
    property int code
    signal clicked
    color: "black"
    width:200
    height: 220
    radius: 5
    FileIO{
        id: file
    }
    Text{
        text: roomName
        color: "white"
        anchors{
            top: parent.top
            horizontalCenter: parent.horizontalCenter
            topMargin: 5
        }
        wrapMode: Text.Wrap
    }
    Image{
        source: roomImage
        sourceSize.width: 180
        sourceSize.height: 100
        anchors{
            horizontalCenter: parent.horizontalCenter
            top:parent.top
            topMargin: 20
        }
    }
    Text{
        text: "Nhiệt độ: " + temperature + "°C"
        color:"white"
        anchors{
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
            bottomMargin: 75
        }
        wrapMode: Text.Wrap
    }
    Text{
        text: deviceWorking + " TB đang được sử dụng"
        color:"white"
        anchors{
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
            bottomMargin: 25
        }
        wrapMode: Text.Wrap
    }

    Text{
        text: "Độ ẩm: " + humidity + "%"
        color:"white"
        anchors{
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
            bottomMargin: 50
        }
        wrapMode: Text.Wrap
    }
    MouseArea{
        anchors.fill: parent
        onClicked: {
            parent.clicked()
            Js.choseRoom(code,false)
        }
    }
}
