import QtQuick 2.0
import QtMultimedia 5.6

Column {
    id: configControllerColumn
    property bool isSelected: false
    property int menuSize: this.height / 15

    spacing: 1


    ListView {
        model: root.gameNameList
        anchors.left: parent.left
        anchors.right: parent.right
        height: 500
        delegate: Item {
            height: 100
            width: 100
            Text { id:aaa; text: modelData; color:"white";font.pixelSize: 25 }
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





    function handleUp() {

    }

    function handleDown() {

    }


    function handleLeft() {

    }

    function handleRight() {

    }

    function handleSelect() {

    }

    function handleBack() {

    }
}

