import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtMultimedia 5.6

Item {
    id: mainMenuRoot
    width: Math.max(gameSelect.width,controlSettings.width,videoSettings.width,audioSettings.width) + root.width/100

    property int menuSize: this.height / 15

    property bool wasSelectPushedBefore: false;
    property bool wasUpPushedBefore: false;
    property bool wasDownPushedBefore: false;
    property var indexes : [gameSelect,controlSettings,videoSettings,audioSettings]

    property int sIndex: 0

    onSIndexChanged: {
        for(var i=0;i<indexes.length;i++) {
            if(i != sIndex) {
                indexes[i].curSelected = false;
            }
        }
        console.debug(sIndex)
        indexes[sIndex].curSelected = true;
    }


    function handleUpState( newVal) {
        if(newVal == 1) {
            wasUpPushedBefore = true;
        } else if(newVal == 0 && wasUpPushedBefore) {
            wasUpPushedBefore = false;
            if(sIndex==0) {
                sIndex = 3;
            } else {
                sIndex--;
            }
        }
    }

    function handleDownState( newVal) {
        if(newVal == 1) {
            wasDownPushedBefore = true;
        } else if(newVal == 0 && wasDownPushedBefore) {
            wasDownPushedBefore = false;
            if(sIndex >= 3) {
                sIndex =0;
            } else {
                sIndex++;
            }
        }

    }

    function handleSelectState( newVal) {
        if(newVal == 1) {
            wasSelectPushedBefore = true;
        } else if(newVal == 0 && wasSelectPushedBefore) {
            wasSelectPushedBefore = false;
            console.log("a");
        }
    }


    Rectangle {
        color:"#00AAFF"
        opacity: .5
        radius: root.width/200
        x: indexes[sIndex].x + root.width/200
        y: indexes[sIndex].y
        width: indexes[sIndex].width
        height: indexes[sIndex].height
        Behavior on y {NumberAnimation{duration:150;}}
        Behavior on width {NumberAnimation{duration:150;}}
    }

    Column {
        id: itemColumn
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: root.width/200
        anchors.rightMargin: root.width/200

        spacing: 1
        Text {
            id: gameSelect
            property bool curSelected: true
            font.pixelSize: menuSize
            color: "white"
            text:qsTr("Select Game")
//            layer.enabled: true
//            layer.effect: Glow {
//                radius: gameSelect.curSelected ? 16 :0
//                samples: radius * 2
//                source: gameSelect
//                color: "blue"
//                spread: .5
//            }
        }

        Text {
            id: controlSettings
            property bool curSelected: false
            font.pixelSize: menuSize
            color: "white"
            text:qsTr("Configure Controllers")
//            layer.enabled: true
//            layer.effect: Glow {
//                radius: controlSettings.curSelected ? 16 :0
//                samples: radius * 2
//                source: controlSettings
//                color: "blue"
//                spread: .5
//            }
        }

        Text {
            id: videoSettings
            property bool curSelected: false
            font.pixelSize: menuSize
            color: "white"
            text:qsTr("Configure Video")
            layer.enabled: true
//            layer.effect: Glow {
//                radius: videoSettings.curSelected ? 16 :0
//                samples: radius * 2
//                source: videoSettings
//                color: "blue"
//                spread: .5
//            }
        }

        Text {
            id: audioSettings
            property bool curSelected: false
            font.pixelSize: menuSize
            color: "white"
            text:qsTr("Configure Audio")
            layer.enabled: true
//            layer.effect: Glow {
//                radius: audioSettings.curSelected ? 16 :0
//                samples: radius * 2
//                source: audioSettings
//                color: "blue"
//                spread: .5

//            }
        }

    }



    focus: true



    Keys.onPressed:  {
        if(event.key == Qt.Key_Down) {
            if(sIndex >= 3) {
                sIndex =0;
            } else {
                sIndex++;
            }
            event.accepted = true;
        } else if(event.key == Qt.Key_Up) {
            if(sIndex==0) {
                sIndex = 3;
            } else {
                sIndex--;
            }
            event.accepted = true;
        }
    }

}

