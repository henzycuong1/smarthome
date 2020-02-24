import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Dialogs 1.2
import "main.js" as Js

MessageDialog {
    property string newTitle
    property string newText
    property string newInfomativeText
    title: newTitle
    text: newText
    informativeText: newInfomativeText
    standardButtons: MessageBox.Ok
}
