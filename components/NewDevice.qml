import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.0
import QtQuick.Layouts 1.0
import "../main.js" as Js

Rectangle {
    id: clickArea
    width: 100
    height: 100
    signal clicked
    color: "transparent"
    border.color: hoverItem ? "transparent" : "black"
    border.width: 1
    property bool displayDeviceInput: false
    property string currentDeviceName: inputDeviceName.text
    property int code
    property int itemNumber
    property bool pressed : false
    property bool hoverItem: false
    property bool leftInput: false
    property bool rightInput: false
    property bool onOff: false
    property int currentTemperutare: 16
    property bool displayLevelRow: false
    property bool displayUpDownTemperature: false
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            hoverItem ? undefined : pressed ? undefined : parent.border.color = "yellow"
        }
        onExited: {
            parent.border.color = hoverItem ? "transparent" : "black"
        }
        onPressed: {
            parent.pressed = true
        }
        onPositionChanged: {
            parent.pressed ? Js.itemChangePosition(mouse,itemNumber) : undefined
        }
        onReleased: {
            Js.itemHasBeenChangePosition(itemNumber)
            parent.pressed = false
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
            left: leftInput ? parent.right : undefined
            right: rightInput ? parent.left : undefined
            leftMargin: leftInput ? 10 : undefined
            rightMargin: rightInput ? 10 : undefined
            verticalCenter: parent.verticalCenter
        }
        ComboBox{
            id: inputDiviceName
            width: 120
            model: ["Den", "Quat", "Tivi", "DieuHoa"]
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
    Image {
        id: center
        source: "../icon/center.png"
        opacity: 0.5
        visible: hoverItem ? true : false
        anchors{
            verticalCenter: parent.verticalCenter
            verticalCenterOffset: 20
            left: parent.left
            leftMargin: 30
        }
    }
    RowLayout{
        anchors{
            top:center.top
            left:center.left
            bottom: center.bottom
            right: center.right
        }
        Image{
            source: onOff ? "../icon/lighton.png" : "../icon/lightoff.png"
            sourceSize.width: 30
            sourceSize.height: 30
            Layout.alignment: Qt.AlignLeft
            Layout.topMargin: 8
            visible: hoverItem ? true : false
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    onOff = !onOff
                }
            }
        }
        Rectangle{
            width: 25
            height: 25
            visible: code == 1 && hoverItem ? true : false
            radius: 100
            color: "transparent"
            border.width: 1
            border.color: "white"
            Layout.topMargin: 8
            Layout.rightMargin: 5
            Layout.alignment: Qt.AlignRight
            Text {
                id: showLevel
                color: "white"
                anchors.centerIn: parent
                text: "0"
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if(levelRow.visible) timerLevelRow.running = true
                    levelRow.visible = true
                    displayLevelRow = !displayLevelRow
                }
            }
        }
        Rectangle{
            width: 50
            height: 25
            radius: 3
            color:"transparent"
            visible: code == 2 && hoverItem? true : false
            Layout.topMargin: 8
            Layout.rightMargin: 2
            Layout.alignment: Qt.AlignRight
            Text{
                id: showVolume
                anchors{
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                    rightMargin: 35
                }

                color:"white"
                text: "0%"
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    sliderVolume.visible = !sliderVolume.visible
                }
            }
            Image {
                source: sliderVolume.value === 0 ? "../icon/volume-off.png" : "../icon/volume-on.png"
                sourceSize.width: 20
                sourceSize.height: 20
                anchors{
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                    rightMargin: 3
                }
            }
        }
        Rectangle{
            width: 50
            height: 25
            radius: 3
            color:"transparent"
            visible: code == 3 && hoverItem ? true : false
            Layout.topMargin: 8
            Layout.rightMargin: 2
            Layout.alignment: Qt.AlignRight
            Text {
                id: showTemperature
                color: "white"
                anchors{
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                    rightMargin: 35
                }

                text: currentTemperutare + " °C"
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if(upDownTemperature.visible) timerUpDownTemperature.running = true
                    upDownTemperature.visible = true
                    displayUpDownTemperature = !displayUpDownTemperature

                }
            }
            Image {
                source: "../icon/air-conditioning.png"
                sourceSize.width: 20
                sourceSize.height: 20
                anchors{
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                    rightMargin: 3
                }
            }
        }
    }
    Rectangle{
        id: levelRow
        visible: false
        width: displayLevelRow ? 162 : 0
        color: Qt.rgba(0,0,0,0.5)
        height: 30
        radius: 5
        anchors{
            top: center.bottom
            topMargin: 5
        }
        Behavior on width{
            NumberAnimation{ duration: 500 }
        }
        Timer{
            interval: 500
            running: false
            id: timerLevelRow
            onTriggered: levelRow.visible = false
        }

        Row{
            spacing: displayLevelRow ? 3 : -30
            Behavior on spacing{
                NumberAnimation{ duration: 500 }
            }

            Rectangle{
                width: 30
                height: 30
                radius: 100
                color: "transparent"
                border.color: "white"
                border.width: 1
                Text {
                    color: "white"
                    anchors.centerIn: parent
                    text: "1"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        showLevel.text = "1"
                    }
                }
            }
            Rectangle{
                width: 30
                height: 30
                radius: 100
                color: "transparent"
                border.color: "white"
                border.width: 1
                Text {
                    color: "white"
                    anchors.centerIn: parent
                    text: "2"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        showLevel.text = "2"
                    }
                }
            }
            Rectangle{
                width: 30
                height: 30
                radius: 100
                color: "transparent"
                border.color: "white"
                border.width: 1
                Text {
                    color: "white"
                    anchors.centerIn: parent
                    text: "3"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        showLevel.text = "3"
                    }
                }
            }
            Rectangle{
                width: 30
                height: 30
                radius: 100
                color: "transparent"
                border.color: "white"
                border.width: 1
                Text {
                    color: "white"
                    anchors.centerIn: parent
                    text: "4"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        showLevel.text = "4"
                    }
                }
            }
            Rectangle{
                width: 30
                height: 30
                radius: 100
                color: "transparent"
                border.color: "white"
                border.width: 1
                Text {
                    color: "white"
                    anchors.centerIn: parent
                    text: "5"
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        showLevel.text = "5"
                    }
                }
            }
        }
    }
    Slider{
        id: sliderVolume
        visible: false
        from: 0
        to: 100
        anchors{
            top: center.bottom
            topMargin: 5
            horizontalCenter: center.horizontalCenter
        }
        onMoved: {
            showVolume.text = this.value.toFixed(1) + "%"
        }
    }
    Rectangle{
        id: upDownTemperature
        width: 35
        height: displayUpDownTemperature ? 100 : 0
        visible: false
        color: Qt.rgba(0,0,0,0.5)
        radius: 5
        anchors{
            left: center.right
            verticalCenter: center.verticalCenter
            leftMargin: 10
        }
        Behavior on height{
            NumberAnimation { duration: 500 }
        }

        Rectangle{
            width: 35
            height: 35
            radius: 100
            color:"transparent"
            border.color: "white"
            border.width: 1
            anchors{
                top: parent.top
                topMargin: displayUpDownTemperature ? 0 : parent.height/2
            }
            Behavior on anchors.topMargin {
                NumberAnimation{ duration: 500 }
            }

            Text{
                anchors.centerIn: parent
                text: "UP"
                color:"white"
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if(currentTemperutare < 30) currentTemperutare++
                }
            }
        }
        Rectangle{
            width: 35
            height: 35
            radius: 100
            color:"transparent"
            border.color: "white"
            border.width: 1
            anchors{
                bottom: parent.bottom
                bottomMargin: displayUpDownTemperature ? 0 : parent.height/2
            }
            Behavior on anchors.bottomMargin {
                NumberAnimation { duration: 500 }
            }

            Text{
                anchors.centerIn: parent
                text: "DOWN"
                color:"white"
            }
            MouseArea{
                anchors.fill: parent
                onClicked:{
                    if(currentTemperutare > 16 ) currentTemperutare--
                }
            }
        }
        Timer{
            interval: 500
            running: false
            id: timerUpDownTemperature
            onTriggered: upDownTemperature.visible = false
        }
    }
}
