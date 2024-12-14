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

            property var imageList: [
                "images/pics/1.jpg",
                "images/pics/2.jpg",
                "images/pics/3.jpg",
                "images/pics/4.jpg",
                "images/pics/5.jpg",
                "images/pics/6.jpg",
                "images/pics/7.jpg",
                "images/pics/8.jpg",
                "images/pics/9.jpg",
                "images/pics/10.jpg",
                "images/pics/11.jpg",
                "images/pics/12.jpg",
                "images/pics/13.jpg",
                "images/pics/14.jpg",
                "images/pics/15.jpg",
                "images/pics/16.jpg",
                "images/pics/17.jpg",
                "images/pics/18.jpg",
                "images/pics/19.jpg",
                "images/pics/20.jpg",
                "images/pics/21.jpg",
                "images/pics/22.jpg",
                "images/pics/23.jpg",
                "images/pics/24.jpg",
                "images/pics/25.jpg",
                "images/pics/26.jpg",
                "images/pics/27.jpg",
                "images/pics/28.jpg",
                "images/pics/29.jpg",
                "images/pics/30.jpg",
                "images/pics/31.jpg",
                "images/pics/32.jpg",
                "images/pics/33.jpg",
                "images/pics/34.jpg",
                "images/pics/35.jpg",
                "images/pics/36.jpg",
                "images/pics/37.jpg",
                "images/pics/38.jpg",
                "images/pics/39.jpg",
                "images/pics/40.jpg",
                "images/pics/41.jpg",
                "images/pics/42.jpg",
                "images/pics/43.jpg",
                "images/pics/44.jpg",
                "images/pics/45.jpg",
                "images/pics/46.jpg",
                "images/pics/47.jpg",
                "images/pics/48.jpg",
                "images/pics/49.jpg",
                "images/pics/50.jpg",
                "images/pics/51.jpg",
                "images/pics/52.jpg",
                "images/pics/53.jpg",
                "images/pics/54.jpg",
                "images/pics/55.jpg"
            ];

            property var textList: [
                "устрой дестрой!",
                "я тут уместен, как на ковровой дорожке коровья лепёшка!",
                "не угадал - мне нет дела до твоей хуйни!",
                "в фигуре Давида чётко видят только... только... член.",
                "ну а я вот парикмахер - никому не нужен на хер",
                "иди-ка ты, Нео доморощенный, дома шелести своим плащом",
                "не важно кто ты, будешь лысый как Нагиев - превратишься в скелетона или в старого гандона",
                "коллапс – это максимум, что предложить может мой словарный запас",
                "я приведу домой бомжа: мне его жаль.",
                "мегаполис — это тесный барак, человек человеку тут враг",
                "забудь логические построения и прекрати осмысление!",
                "жизнь хороша, но в ней хватает дерьма.",
                "рекомендую здесь все тебе все вокруг воспринимать адекватно",
                "чужая слабость не делает тебя сильней.",
                "чужая глупость не делает умней тебя.",
                "и если рядом много плохих людей - не стань одним из них, сохранить сумей себя."
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
