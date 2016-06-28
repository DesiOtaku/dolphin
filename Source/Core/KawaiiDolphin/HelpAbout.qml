import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: aboutRoot
    Column {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: aboutRoot.height / 25
            color: "white"
            text: qsTr("Dolphin GameCube/Wii Emulator")
        }
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: aboutRoot.height / 25
            color: "white"
            text: qsTr("(C) 2016; Licensed under GPLv2+")
        }
        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: aboutRoot.height / 25
            color: "white"
            text: qsTr("Kawaii Fork made by Tej A. Shah (DesiOtaku)")
        }
    }



    Image {
        id: logo
        anchors.fill: parent
        source: "qrc:/icons/dolphin-emu.svg"
        fillMode: Image.PreserveAspectFit
        smooth: true
    }

    Glow {
        id: glowLogo
        anchors.fill: logo
        radius: 32
        samples: 32
        color: "white"
        source: logo
        Behavior on color {
            ColorAnimation {
                duration: 500
            }
        }

        SequentialAnimation {
            loops: Animation.Infinite
            running: true
            NumberAnimation { target: glowLogo; property: "spread"; from:0; to: 1; duration: 5000}
            NumberAnimation { target: glowLogo; property: "spread"; from:1; to: 0; duration: 5000}
            ScriptAction {script: {glowLogo.color = Qt.rgba(Math.random(),Math.random(),Math.random(),1);}}
        }
    }
}

