import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.0
import "../main.js" as Js
RowLayout {
    property bool onOff: false
    property bool onOffSpeed: false
    property bool onOffTemperature: false
    property bool onOffVolume: false
    property int currentTemperature: 16
    property bool displayBOnOff: false
    property bool displayBSpeed: false
    property bool displayBTemperature: false
    property bool displayBVolume: false
     spacing: 10
     anchors{
         left: parent.left
         leftMargin: 10
         bottom: parent.bottom
     }
     height: 115
    Rectangle{
        id: bOnOff
        width: 65
        height: 65
        radius: 10
        visible: displayBOnOff
        gradient: Gradient{
            GradientStop { position: 0.0; color: "#8a7b7d" }
            GradientStop { position: 1.0; color: "#b28755" }
        }
        Layout.alignment: Qt.AlignVCenter
        Text {
            id: tOnOff
            text: onOff ? "ON" : "OFF"
            anchors{
                bottom: parent.bottom
                bottomMargin: 2
                horizontalCenter: parent.horizontalCenter
            }
            color: "white"
            font.pointSize: 16
        }
        Image{
            id: iconOnOff
            source: onOff ? "../icon/lighton.png" : "../icon/lightoff.png"
            anchors{
                top: parent.top
                topMargin: 2
                horizontalCenter: parent.horizontalCenter
            }
            sourceSize.height: 40
            sourceSize.width: 40
        }

        MouseArea{
           anchors.fill: parent
           onClicked: {
               onOff = !onOff
           }
        }
    }
    Rectangle{
        id: bSpeed
        width: 65
        height: 65
        radius: 10
        visible: displayBSpeed
        gradient: Gradient{
            GradientStop { position: 0.0; color: "#8a7b7d" }
            GradientStop { position: 1.0; color: "#b28755" }
        }
        Text {
            id: tSpeed
            text: "Tốc độ"
            anchors{
                centerIn: tCurrentSpeed.visible ? undefined : parent;
                bottom: tCurrentSpeed.visible ? parent.bottom : undefined;
                bottomMargin: tCurrentSpeed.visible ? 3 : undefined;
                horizontalCenter: tCurrentSpeed.visible ? parent.horizontalCenter : undefined;
            }
            color: "white"
            font.pointSize: 16
        }
        Text{
            id: tCurrentSpeed
            text: "0"
            anchors{
                top: parent.top
                topMargin: 3
                horizontalCenter: parent.horizontalCenter
            }
            visible: onOffSpeed
            font.pointSize: 16
            color: "white"
        }

        MouseArea{
            anchors.fill: parent
            onClicked: {
                onOffSpeed = !onOffSpeed
            }
        }
    }
    Slider{
        id: bSlider
        visible: onOffSpeed
        from: 0
        to: 100
        Layout.alignment: Qt.AlignVCenter
        onMoved: {
            tCurrentSpeed.text = bSlider.value.toFixed(1) + "%"
        }
    }
    Rectangle{
        id: bTemperature
        width: 65
        height: 65
        radius: 10
        visible: displayBTemperature
        gradient: Gradient{
            GradientStop { position: 0.0; color: "#8a7b7d" }
            GradientStop { position: 1.0; color: "#b28755" }
        }
        Text {
            id: tTemperature
            text: "Nhiệt độ"
            anchors{
                centerIn: tCurrentTemperature.visible ? undefined : parent;
                bottom: tCurrentTemperature.visible ? parent.bottom : undefined;
                bottomMargin: tCurrentTemperature.visible ? 3 : undefined;
                horizontalCenter: tCurrentTemperature.visible ? parent.horizontalCenter : undefined;
            }
            color: "white"
            font.pointSize: 16
        }
        Text{
            id: tCurrentTemperature
            text: currentTemperature + "*C"
            anchors{
                top: parent.top
                topMargin: 3
                horizontalCenter: parent.horizontalCenter
            }
            visible: onOffTemperature
            font.pointSize: 16
            color: "white"
        }

        MouseArea{
            anchors.fill: parent
            onClicked: {
                onOffTemperature = !onOffTemperature
            }
        }
    }
    Rectangle{
        id: bUpDown
        width: 40
        height: parent.height
        visible: onOffTemperature
        color: "transparent"
        Rectangle{
            width:parent.width
            height: 40
            radius: 100
            color: "transparent"
            border.color: "white"
            border.width: 1
            anchors{
                top: parent.top
            }

            Text {
                id: tUp
                text: "Up"
                color: "white"
                font.pointSize: 10
                anchors.centerIn: parent
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    currentTemperature += 1
                }
            }
        }
        Rectangle{
            width:parent.width
            height: 40
            radius: 100
            border.color: "white"
            color: "transparent"
            border.width: 1
            anchors{
                bottom: parent.bottom
            }

            Text {
                id: tDown
                text: "Down"
                color: "white"
                font.pointSize: 10
                anchors.centerIn: parent
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    currentTemperature -= 1
                }
            }
        }
    }
    Rectangle{
        id: bVolume
        width: 65
        height: 65
        radius: 10
        visible: displayBVolume
        gradient: Gradient{
            GradientStop { position: 0.0; color: "#8a7b7d" }
            GradientStop { position: 1.0; color: "#b28755" }
        }
        Text {
            id: tVolume
            text: "Âm lượng"
            anchors{
                centerIn: tCurrentVolume.visible ? undefined : parent;
                bottom: tCurrentVolume.visible ? parent.bottom : undefined;
                bottomMargin: tCurrentVolume.visible ? 3 : undefined;
                horizontalCenter: tCurrentVolume.visible ? parent.horizontalCenter : undefined;
            }
            color: "white"
            font.pointSize: 16
        }
        Text{
            id: tCurrentVolume
            text: "0"
            anchors{
                top: parent.top
                topMargin: 3
                horizontalCenter: parent.horizontalCenter
            }
            visible: onOffVolume
            font.pointSize: 16
            color: "white"
        }

        MouseArea{
            anchors.fill: parent
            onClicked: {
                onOffVolume = !onOffVolume
            }
        }
    }
    Slider{
        id: bSliderVolume
        visible: onOffVolume
        from: 0
        to: 100
        Layout.alignment: Qt.AlignVCenter
        onMoved: {
            tCurrentVolume.text = bSliderVolume.value.toFixed(1) + "%"
        }
    }
}
