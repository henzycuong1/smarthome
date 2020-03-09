import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.0
import FileIO 1.0
import "../main.js" as Js
Rectangle {
    id: lockScreen
    width: parent.width
    height: parent.height
    color: "black"
    property int lockScreenY: lockScreen.y
    signal doubleClicked
    FontLoader {
        id: robotoLight
        name: "roboto light"
        source: "../Font/Roboto-Light.ttf"
    }
    FileIO{
        id:file
    }
    MouseArea{
        anchors.fill: parent
        onDoubleClicked:{
             parent.doubleClicked()
            console.log("double click")
        }
    }
    Rectangle{
        id: leftLockScreen
        width: 100
        height: 460
        radius: 10
        color: Qt.rgba(255,255,255,0.5)
        anchors{
            top: parent.top
            bottom: parent.bottom
            left: parent.left
            topMargin: 10
            leftMargin: 10
            bottomMargin: 10
        }
        ColumnLayout{
            anchors.fill: parent
            spacing: 10
            Image {
                source: "../icon/unlock.png"
                Layout.alignment: Qt.AlignHCenter
                sourceSize.width: 80
                sourceSize.height: 80
            }
            Image {
                source: "../icon/fire.png"
                Layout.alignment: Qt.AlignHCenter
                sourceSize.width: 80
                sourceSize.height: 80
            }
            Image {
                source: "../icon/gas.png"
                Layout.alignment: Qt.AlignHCenter
                sourceSize.width: 80
                sourceSize.height: 80
            }
            Image {
                source: "../icon/water.png"
                Layout.alignment: Qt.AlignHCenter
                sourceSize.width: 80
                sourceSize.height: 80
            }
        }
    }
    Rectangle{
        id: rightLockScreen
        radius: 10
        color: Qt.rgba(255,255,255,0.5)
        anchors{
            top:parent.top
            left: leftLockScreen.right
            right: parent.right
            bottom: parent.bottom
            topMargin: 10
            rightMargin: 10
            leftMargin: 20
            bottomMargin: 10
        }
        ScrollView{
            anchors.fill: parent
            GridLayout{
                id: layoutRightLockScreen
                anchors.fill: parent
                function getColumn () {
                    let data = JSON.parse(file.readFile("data.json"))
                    if(data.length === 1) return 1
                    else if(data.length === 2) return 2
                    else if(data.length > 2) return 3
                    else return 0
                }
                function getRow (){
                    let data = JSON.parse(file.readFile("data.json"))
                    return parseInt(data.length / 3) + 1
                }
                columns: getColumn()
                rows: getRow()
                anchors.margins: 10
                rowSpacing: 5
                columnSpacing: 10
            }
        }
    }
    Component.onCompleted: {
        let data = JSON.parse(file.readFile("data.json"))
        let comp = Qt.createComponent("ItemLockScreen.qml")
        if(comp.status !== Component.Ready){
            if(comp.status === Component.Error){
                Js.showMessage("UI SYSTEM ERROR","COMPONENT ERROR: " + comp.errorString())
                return
            }
        }
        for(let i = 0; i < data.length ; i++){
            let obj = comp.createObject(layoutRightLockScreen,{
                                            "roomName":data[i].Room.name,
                                            "roomImage":data[i].Room.imageURL,
                                            "temperature": 0,
                                            "humidity":0,
                                            "code": i,
                                            "deviceWorking":0
                                        })
        }
    }
}
