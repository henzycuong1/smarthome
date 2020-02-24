import QtQuick 2.0
import QtGraphicalEffects 1.0
import "main.js" as Js
import "."
Rectangle {
    id: rectangle
    width: 800
    height: 480
    color: "#72c994"
    z:-2
    gradient: Gradient {
        GradientStop {
            position: 0
            color: "#72c994"
        }

        GradientStop {
            position: 1
            color: "#2d897e"
        }
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
    Rectangle {
        id: rectangle1
        x: 748
        y: 78
        width: 200
        height: 200
        color: "#ffffff"
        radius: 100
        opacity: 0.1
        border.width: 0
    }

    Rectangle {
        id: rectangle2
        x: 626
        y: 167
        width: 200
        height: 200
        color: "#ffffff"
        radius: 100
        border.width: 0
        opacity: 0.1
    }

    Rectangle {
        id: rectangle3
        x: -141
        y: -68
        width: 200
        height: 200
        color: "#ffffff"
        radius: 100
        opacity: 0.1
        border.width: 0
    }

    Rectangle {
        id: rectangle4
        x: -13
        y: -156
        width: 200
        height: 200
        color: "#ffffff"
        radius: 100
        border.width: 0
        opacity: 0.1
    }
    Text {
        id: tSmartHome
        y: 26
        anchors.horizontalCenter: parent.horizontalCenter
        color: "#ffffff"
        text: qsTr("SMART HOME")
        font.bold: true
        font.family: robotoBold.name
        font.pixelSize: 40
    }

    Text {
        id: tContent
        anchors.horizontalCenter: parent.horizontalCenter
        y: 84
        color: "#ffffff"
        text: qsTr("Một quản gia đặc biệt cho ngôi nhà của bạn.")
        font.family: robotoBold.name
        font.pixelSize: 20
    }
}


