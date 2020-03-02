import QtQuick 2.12
import QtGraphicalEffects 1.0
import "main.js" as Js
import "."

Image {
    id: background
    property bool tSmartHomeVisiable
//    width: 800
//    height: 480
//    color: "#72c994"
    z: -2
//    gradient: Gradient {
//        GradientStop {
//            position: 0
//            color: "#72c994"
//        }

//        GradientStop {
//            position: 1
//            color: "#2d897e"
//        }
//    }
    source: "icon/Background.bmp"
    sourceSize.width: 800
    sourceSize.height: 480
    FontLoader {
        id: robotoBold
        name: "roboto bold"
        source: "Font/Roboto-Bold.ttf"
    }
    FontLoader {
        id: robotoLight
        name: "roboto light"
        source: "Font/Roboto-Light.ttf"
    }
    FontLoader {
        id: robotoRegular
        name: "roboto regular"
        source: "Font/Roboto-Regular.ttf"
    }
    Image{
        id: logo
        width: 360
        height: 132
        source: "icon/Logo.png"
        visible: true
        anchors{
            top: tSmartHomeVisiable ? parent.top : undefined
            topMargin: tSmartHomeVisiable ? 10 : undefined
            horizontalCenter:  tSmartHomeVisiable ? parent.horizontalCenter : undefined
            centerIn: tSmartHomeVisiable ? undefined : parent
        }
    }

//    Text {
//        id: tSmartHome
//        visible: tSmartHomeVisiable
//        anchors{
//            top: logo.bottom
//            topMargin: 10
//            horizontalCenter: parent.horizontalCenter
//        }
//        color: "#ffffff"
//        text: qsTr("SMART HOME")
//        font.bold: true
//        font.family: robotoBold.name
//        font.pixelSize: 40
//    }
}
