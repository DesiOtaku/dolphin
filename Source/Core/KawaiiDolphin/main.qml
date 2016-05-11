import QtQuick 2.0
import QtQuick.Particles 2.0
import QtGraphicalEffects 1.0

Item {
    id: root

    property int selectButtonPushed:0;
    property int downButtonPushed:0;
    property int upButtonPushed:0;

    onSelectButtonPushedChanged: mainMenuBar.handleSelectState(selectButtonPushed);
    onDownButtonPushedChanged: mainMenuBar.handleDownState(downButtonPushed);
    onUpButtonPushedChanged: mainMenuBar.handleUpState(upButtonPushed);


    Rectangle {
        id: background
        color: "#050505"
        anchors.fill: parent
        Image {
            id: logo
            anchors.centerIn: parent
            anchors.fill: parent
            source: "qrc:/icons/dolphin-emu.svg"
            fillMode: Image.PreserveAspectFit
            opacity: .05
        }

        ParticleSystem {
            id: partSys
            running: true
        }

        Emitter {
            id: emitter
            anchors.fill: parent
            system: partSys
            emitRate: 10
            lifeSpan: 10000
            lifeSpanVariation: 5000
            size: .1
            startTime: 10000
            opacity: .1
            velocity: AngleDirection {
                angleVariation: 30
                magnitude: 20
                magnitudeVariation: 10
            }

        }

        ItemParticle {
            delegate: Rectangle {
                color: "white"
                width:1
                height:1
                radius: 1
                antialiasing: true
            }
            system: partSys
        }


//        Glow {
//            id: glow
//            anchors.fill: logo
//            radius: root.width/50
//            samples: 17
//            color: "white"
//            source: logo
//            visible: false

//            SequentialAnimation {
//                NumberAnimation {
//                    target: glow
//                    property: "radius"
//                    from: 5
//                    to: 100
//                    duration: 5000
//                }
//                NumberAnimation {
//                    target: glow
//                    property: "radius"
//                    from: 100
//                    to: 5
//                    duration: 5000
//                }
//                loops: Animation.Infinite
//                running: true
//            }


//        }
    }

    Text {
        id: name
        color:"white"
        text: qsTr("Dolphin")
        font.pixelSize: parent.height/10
        style: Text.Raised
        styleColor: "blue"
        anchors.horizontalCenter: parent.horizontalCenter


        PropertyAnimation on opacity {
            from: 0
            to: 1
            duration: 1000
        }
    }


    MainMenu {
        id:mainMenuBar
        anchors.left: parent.left
        anchors.top: name.bottom
        anchors.bottom: parent.bottom
        anchors.bottomMargin: parent.height/100
        anchors.leftMargin: parent.width/100
    }

}
