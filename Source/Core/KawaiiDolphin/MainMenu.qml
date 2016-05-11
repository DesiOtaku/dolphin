import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: mainMenuRoot
    property int smallSize: this.height / 20
    property int bigSize: this.height / 10
    width: gameSelect.width + root.width/100

    Rectangle {
        color: "steelblue"
        opacity: .1
        anchors.fill: parent
        radius: root.width/200
    }

    Column {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: root.width/200
        anchors.rightMargin: root.width/200

        spacing: 1
        Text {
            id: gameSelect
            font.pixelSize: mainMenuRoot.bigSize
            color: "white"
            text:qsTr("Select Game")
            layer.enabled: true
            layer.effect: Glow {
                radius: 10
                samples: radius * 2
                source: gameSelect
                color: "blue"
                spread: .5
            }
        }

        Text {
            id: controlSettings
            font.pixelSize: mainMenuRoot.smallSize
            color: "white"
            text:qsTr("Configure Controllers")
            layer.enabled: true
            layer.effect: Glow {
                radius: 0
                samples: radius * 2
                source: controlSettings
                color: "blue"
                spread: .5
            }
        }

        Text {
            id: videoSettings
            font.pixelSize: mainMenuRoot.smallSize
            color: "white"
            text:qsTr("Configure Video")
            layer.enabled: true
            layer.effect: Glow {
                radius: 0
                samples: radius * 2
                source: videoSettings
                color: "blue"
                spread: .5
            }
        }

        Text {
            id: audioSettings
            font.pixelSize: mainMenuRoot.smallSize
            color: "white"
            text:qsTr("Configure Audio")
            layer.enabled: true
            layer.effect: Glow {
                radius: 0
                samples: radius * 2
                source: audioSettings
                color: "blue"
                spread: .5
            }
        }

    }

    focus: true

    Keys.onPressed:  {
        if(event.key == Qt.Key_Down) {
            //TODO: everything!
            event.accepted = true;
        }
    }

}

