import QtQuick 2.12
import QtQuick.Window 2.0
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.0
import QtMultimedia 5.12
import "../main.js" as Js

Item{
    id: bell
    anchors.centerIn: parent
    property var imageList: []
    function addPicture(source){
        var image = {
            "id": source,
            "source": source
        }
        imageList.push(image);
        bell.imageListChanged();
    }
    Image {
        id: iconBell
        source: "../icon/bell.png"
        sourceSize.width: 200
        sourceSize.height: 200
        anchors.centerIn: parent
        MouseArea{
            anchors.fill: parent
            onClicked: {
                cameraContainer.visible = true
                console.log("bell")
            }
        }
        RotationAnimator{
            target: iconBell
            from: -35
            to: 35
            running: true
            duration: 1000
            loops: Animator.Infinite
        }
    }
    Rectangle{
        id: cameraContainer
        width: 480
        height: 400
        visible: false
        border.color: "black"
        border.width: 1
        anchors.centerIn: parent
        Rectangle{
            height: 40
            color: "black"
            anchors{
                right: parent.right
                left: parent.left
                top: parent.top
            }
            Image{
                source: "../icon/closebutton.png"
                sourceSize.width: 25
                sourceSize.height: 25
                anchors{
                    verticalCenter: parent.verticalCenter
                    right: parent.right
                    rightMargin: 10
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        cameraContainer.visible = false
                        bell.visible = false
                    }
                }
            }
            Text{
                text: "CAMERA"
                color: "white"
                anchors.centerIn: parent
                font.pixelSize: 20
            }
        }
        Rectangle{
            height: 360
            border.width: 1
            border.color:"black"
            anchors{
                bottom: parent.bottom
                right: parent.right
                left: parent.left
            }

            Camera{
                id: camera
                imageProcessing.whiteBalanceMode: CameraImageProcessing.WhiteBalanceFlash
                exposure.exposureCompensation: -1.0
                exposure.exposureMode: Camera.ExposurePortrait
                flash.mode: Camera.FlashRedEyeReduction
                imageCapture.onImageCaptured: {
                    photoPreview.source = preview
                    imageList.push(preview)

                }

            }
            VideoOutput {
                source: camera
                height: parent.height - 50
                width: parent.width
                focus : visible
            }
            Rectangle{
                width: 50
                height: 50
                anchors{
                    bottom: parent.bottom
                    horizontalCenter: parent.horizontalCenter
                }

                color:"red"
                radius:100
                border.color: "black"
                border.width: 1
                MouseArea{
                    anchors.fill: parent
                    onPressed: {
                        parent.color = "black"
                        camera.imageCapture.capture()
                        photoPreview.visible = true
                        console.log("Take a picture")
                    }
                    onReleased: {
                        parent.color = "red"

                    }
                }
            }
            Rectangle{
                width: 50
                height: 50
                radius: 100
                color: "red"
                anchors{
                    bottom: parent.bottom
                    right: parent.right
                }
                MouseArea{
                    anchors.fill: parent
                    onPressed: {
                        parent.color = "black"
                        camera.imageCapture.captureToLocation(file.getDateTime())
                    }
                    onReleased: {
                        parent.color = "red"
                    }
                }
            }

            Image{
                id: photoPreview
                anchors{
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        parent.visible = false
                        photoPreview.grabToImage(function(result){
                            MyImageSaver.savePicture(photoPreview.source,result)
                        });
                        MyImageSaver.writePictures()
                    }
                }
            }
        }
    }
}
