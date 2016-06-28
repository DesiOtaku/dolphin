import QtQuick 2.0
import QtMultimedia 5.6

Column {
    id: configControllerColumn
    property bool isSelected: false
    property int menuSize: this.height / 15

    spacing: 1

    ListModel {
        id: menuListModel
        ListElement {
            name: "Set Resolution"
        }
        ListElement {
            name: "Set Renderer"
        }
        ListElement {
            name: "Advance options"
        }
    }

    ListView {
        id: gameListView
        model: menuListModel
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.height
        spacing: root.height / 50
        delegate: Item {
            height: root.height / 10
            width: parent.width;
            Text {
                id: gameText
                text: name;
                color: "white"
                font.pixelSize: root.height / 20
            }
        }

    }



    SoundEffect {
        id: moveSound
        source: "qrc:/sounds/tick.wav"
    }

    SoundEffect {
        id: selectSound
        source: "qrc:/sounds/select.wav"
    }

}
