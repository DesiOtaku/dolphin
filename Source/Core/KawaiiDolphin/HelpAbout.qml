// Copyright 2015 Dolphin Emulator Project
// Licensed under GPLv2+
// Refer to the license.txt file included.

import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Particles 2.0

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



//    Image {
//        id: logo
//        anchors.fill: parent
//        source: "qrc:/icons/dolphin-emu.svg"
//        fillMode: Image.PreserveAspectFit
//        smooth: true
//    }



    ParticleSystem {
        id: partSys
        running: true
    }

    Emitter {
        id: emitter
        anchors.fill: parent
        anchors.leftMargin: aboutRoot.height / 10
        anchors.rightMargin: aboutRoot.height / 10
        system: partSys
        emitRate: 5000
        lifeSpan: 100
        lifeSpanVariation: 500
        size: aboutRoot.height / 50
        //startTime: 10000
        opacity: 1
        velocity: AngleDirection {
            angleVariation: 360
            magnitude: 30
            magnitudeVariation: 10
        }
        shape: MaskShape {
            source: "qrc:/icons/dolphin-emu.svg"
        }

    }

    ImageParticle {
        source: "qrc:/icons/dolphin-emu.svg"
        system: partSys
        autoRotation: true
        colorVariation: 1
        entryEffect: ImageParticle.Scale
    }

//    Glow {
//        id: glowLogo
//        anchors.fill: logo
//        radius: 32
//        samples: 32
//        color: "white"
//        source: logo
//        Behavior on color {
//            ColorAnimation {
//                duration: 500
//            }
//        }

//        SequentialAnimation {
//            loops: Animation.Infinite
//            running: true
//            NumberAnimation { target: glowLogo; property: "spread"; from:0; to: 1; duration: 5000}
//            NumberAnimation { target: glowLogo; property: "spread"; from:1; to: 0; duration: 5000}
//            ScriptAction {script: {glowLogo.color = Qt.rgba(Math.random(),Math.random(),Math.random(),1);}}
//        }
//    }
}

