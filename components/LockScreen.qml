import QtQuick 2.12
import QtQuick.Controls 2.12
import "../main.js" as Js
Rectangle {
    id: lockScreen
    width: 800
    height: 480
    color: "black"
    property int lockScreenY: lockScreen.y
    signal doubleClicked
    FontLoader {
        id: robotoLight
        name: "roboto light"
        source: "../Font/Roboto-Light.ttf"
    }
    MouseArea{
        anchors.fill: parent
        onDoubleClicked: parent.doubleClicked()
    }
    Rectangle{
        id: leftLockScreen
        width: 250
        color: "white"
        opacity: 0.2
        anchors{
            left: parent.left
            top: parent.top
            bottom: parent.bottom
            leftMargin: 20
            topMargin: 20
            bottomMargin: 20
        }
    }
    Image{
        id: iconTemperature
        source: "../icon/temperature.png"
        sourceSize.width: 65
        sourceSize.height: 170
        anchors{
            top: leftLockScreen.top
            left: leftLockScreen.left
            topMargin: 40
            leftMargin: 60
        }
    }
    Text{
        id: tTemperature
        text: "°C"
        font.pointSize: 30
        font.family: robotoLight.name
        color: "white"
        anchors{
            verticalCenter: iconTemperature.verticalCenter
            left: iconTemperature.right
            leftMargin: 30
        }
    }
    Image{
        id: iconHumidity
        source: "../icon/humidity.png"
        sourceSize.width: 100
        sourceSize.height: 120
        anchors{
            bottom: leftLockScreen.bottom
            left: leftLockScreen.left
            bottomMargin: 40
            leftMargin: 45
        }
    }
    Text{
        id: tHumidity
        text: "%"
        font.pointSize: 30
        font.family: robotoLight.name
        color: "white"
        anchors{
            verticalCenter: iconHumidity.verticalCenter
            left: iconHumidity.right
            leftMargin: 30
        }
    }
    Rectangle{
        id: bottomLockScreen
        color: "white"
        opacity: 0.2
        height: 220
        anchors{
            left: leftLockScreen.right
            bottom: parent.bottom
            right: parent.right
            leftMargin: 20
            rightMargin: 20
            bottomMargin: 20
        }
    }
    Image {
        id: iconFire
        source: "../icon/fire.png"
        sourceSize.width: 90
        sourceSize.height: 130
        anchors{
            verticalCenter: bottomLockScreen.verticalCenter
            left: bottomLockScreen.left
            leftMargin: 30
        }
    }
    Image {
        id: iconWater
        source: "../icon/water.png"
        sourceSize.width: 145
        sourceSize.height: 120
        anchors{
            verticalCenter: bottomLockScreen.verticalCenter
            right: bottomLockScreen.right
            rightMargin: 30
        }
    }
    Image {
        id: iconGas
        source: "../icon/gas.png"
        sourceSize.width: 85
        sourceSize.height: 125
        anchors{
            left: iconFire.right
            right: iconWater.left
            leftMargin: 60
            rightMargin: 60
            verticalCenter: bottomLockScreen.verticalCenter
        }
    }
    Rectangle{
        id: topRightLockScreen
        color: "white"
        opacity: 0.2
        width: 235
        anchors{
            right:parent.right
            bottom: bottomLockScreen.top
            top: parent.top
            rightMargin: 20
            topMargin: 20
            bottomMargin: 20
        }
    }
    Image{
        id: iconCO
        source: "../icon/CO.png"
        sourceSize.width: 120
        sourceSize.height: 80
        anchors{
            horizontalCenter: topRightLockScreen.horizontalCenter
            top: topRightLockScreen.top
            topMargin: 35
        }
    }
    Text{
        id: tCO
        text: "%"
        color: "white"
        font.family: robotoLight.name
        font.pointSize: 30
        anchors{
            horizontalCenter: topRightLockScreen.horizontalCenter
            top: iconCO.bottom
            topMargin: 15
        }
    }

    Rectangle{
        id: centerLockScreen
        color: "white"
        opacity: 0.2
        anchors{
            left: leftLockScreen.right
            top: parent.top
            right: topRightLockScreen.left
            bottom: bottomLockScreen.top
            leftMargin: 20
            rightMargin: 20
            topMargin: 20
            bottomMargin: 20
        }
    }
    Image{
        id: iconUnLock
        source: "../icon/unlock.png"
        sourceSize.width: 80
        sourceSize.height: 100
        anchors{
            horizontalCenter: centerLockScreen.horizontalCenter
            top: centerLockScreen.top
            topMargin: 30
        }
    }
    Text{
        id: tUnLock
        text: "cửa chưa khóa"
        color: "white"
        font.family: robotoLight.name
        font.pointSize: 16
        anchors{
            horizontalCenter: centerLockScreen.horizontalCenter
            top: iconUnLock.bottom
            topMargin: 15
        }
    }
}
