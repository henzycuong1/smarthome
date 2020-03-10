import QtQuick 2.12
import QtGraphicalEffects 1.0
import "../main.js" as Js

Image {
    id: background
    property bool isLoginScreen
    source: "../icon/Background.bmp"
    sourceSize.width: 800
    sourceSize.height: 480
    z:-5
    Image{
        id: logo
        width: 360
        height: 132
        source: "../icon/Logo.png"
        visible: true
        anchors{
            top: isLoginScreen ? parent.top : undefined
            topMargin: isLoginScreen ? 10 : undefined
            horizontalCenter:  isLoginScreen ? parent.horizontalCenter : undefined
            centerIn: isLoginScreen ? undefined : parent
        }
    }

}
