import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.0
import FileIO 1.0
import "../main.js" as Js

Image {
    id: imageBackground
    anchors.fill: parent
    property string imageURL
    source: imageURL
    z: -1
    FileIO {
        id: file
    }

}
