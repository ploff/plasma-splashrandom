import QtQuick 2.5
import QtQuick.Window 2.5
import QtQuick.Controls 2.5

Rectangle {
    id: root
    color: "#000000"

    property int stage

    onStageChanged: {
        if (stage == 1) {
            introAnimation.running = true;
        } else if (stage == 5) {
            introAnimation.target = busyIndicator;
            introAnimation.from = 1;
            introAnimation.to = 0;
            introAnimation.running = true;
        }
    }

    Item {
        id: content
        anchors.fill: parent
        opacity: 0

        TextMetrics {
            id: units
            text: "M"
            property int gridUnit: boundingRect.height
            property int largeSpacing: units.gridUnit
            property int smallSpacing: Math.max(2, gridUnit / 4)
        }

        Rectangle {
            property int sizeAnim: 367

            id: imageSource
            width: sizeAnim
            height: sizeAnim
            color: "transparent"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            clip: true;

            property var imageList: [ // known supported formats: jpg, png, gif. maybe more, idk.
                "images/pics/1.jpg",
                "images/pics/2.jpg",
                "images/pics/3.jpg",
                //etc...
            ];

            property var textList: [
                "text 1",
                "text 2",
                "text 3"
                //etc ...
            ];

            function getRandomImage() {
                var randomIndex = Math.floor(Math.random() * imageList.length);
                return imageList[randomIndex];
            }

            function getRandomText() {
                var randomIndex = Math.floor(Math.random() * textList.length);
                return textList[randomIndex];
            }
        }

        AnimatedImage {
            id: face
            source: ""
            paused: false
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: imageSource.sizeAnim - 7
            height: imageSource.sizeAnim - 7
            smooth: false
            visible: true

            Component.onCompleted: {
                face.source = imageSource.getRandomImage();
            }
        }

        Image {
            id: busyIndicator

            y: parent.height - 150
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.margins: units.gridUnit
            source: "images/busywidget.svgz"
            sourceSize.height: units.gridUnit * 2
            sourceSize.width: units.gridUnit * 2

            RotationAnimator on rotation {
                id: rotationAnimator
                from: 0
                to: 360
                duration: 1500
                loops: Animation.Infinite
            }
        }

        Row {
            opacity: 0.5
            spacing: units.smallSpacing * 2
            anchors {
                bottom: parent.bottom
                margins: units.gridUnit
            }

            anchors.horizontalCenter: parent.horizontalCenter

            Text {
                color: "#e0e8f1"
                renderType: Screen.devicePixelRatio % 1 !== 0 ? Text.QtRendering : Text.NativeRendering
                anchors.verticalCenter: parent.verticalCenter

                text: imageSource.getRandomText()
            }

            Image {
                source: "images/kde.svgz"
                sourceSize.height: units.gridUnit * 2
                sourceSize.width: units.gridUnit * 2
            }
        }
    }

    OpacityAnimator {
        id: introAnimation
        running: false
        target: content
        from: 0
        to: 1
        duration: 1000
        easing.type: Easing.InOutQuad
    }
}
