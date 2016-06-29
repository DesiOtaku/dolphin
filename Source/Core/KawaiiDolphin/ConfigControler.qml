// Copyright 2015 Dolphin Emulator Project
// Licensed under GPLv2+
// Refer to the license.txt file included.


import QtQuick 2.0
import QtMultimedia 5.6

Column {
    id: configControllerColumn
    property bool isSelected: false
    property int menuSize: this.height / 15

    spacing: 1


    Text {
        id: gameSelect
        property bool curSelected: true
        font.pixelSize: menuSize
        color: "white"
        text:qsTr("Run Wizard")
        horizontalAlignment: Text.AlignHCenter
        anchors.left: parent.left
        anchors.right: parent.right
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

