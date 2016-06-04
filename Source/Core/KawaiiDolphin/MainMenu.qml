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
    property var indexes : [gameSelect,controlSettings,videoSettings,audioSettings,aboutHelp]
    signal itemActivated(var itemName);
    signal itemSelected(var itemName);

    property int sIndex: 0

    focus: true

    onSIndexChanged: {
        for(var i=0;i<indexes.length;i++) {
            if(i != sIndex) {
                indexes[i].curSelected = false;
            }
        }
        //console.debug(sIndex)
        indexes[sIndex].curSelected = true;
    }


    function handleUpState( newVal) {
        if(!focus) {
            return;
        }

        if(newVal == 1) {
            wasUpPushedBefore = true;
        } else if(newVal == 0 && wasUpPushedBefore) {
            wasUpPushedBefore = false;
            if(sIndex==0) {
                sIndex = indexes.length -1;
            } else {
                sIndex--;
            }
            itemActivated(indexToName(sIndex));
            moveSound.play();
        }

    }

    function handleDownState( newVal) {
        if(!focus) {
            return;
        }

        if(newVal == 1) {
            wasDownPushedBefore = true;
        } else if(newVal == 0 && wasDownPushedBefore) {
            wasDownPushedBefore = false;
            sIndex++;
            if(sIndex >= indexes.length) {
                sIndex =0;
            }
            itemActivated(indexToName(sIndex));
            moveSound.play();
        }
    }

    function handleSelectState( newVal) {
        if(!focus) {
            return;
        }


        if(newVal == 1) {
            wasSelectPushedBefore = true;
        } else if(newVal == 0 && wasSelectPushedBefore) {
            wasSelectPushedBefore = false;
            itemSelected((indexToName(sIndex)));
            selectSound.play();
            focus = false;
        }
    }

    function indexToName(index) {
        switch(index) {
        case 0:
            return "selectGame";
        case 1:
            return "configControl";
        case 2:
            return "configAudio";
        case 3:
            return "configVideo";
        case 4:
            return "helpAbout"
        }
    }

    function regainFocus() {
        focus = true;
    }


    Rectangle {
        id: selectRect
        color:"#00AAFF"
        opacity: mainMenuRoot.focus ? .5 : .25
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
        }

        Text {
            id: controlSettings
            property bool curSelected: false
            font.pixelSize: menuSize
            color: "white"
            text:qsTr("Configure Controllers")
        }

        Text {
            id: videoSettings
            property bool curSelected: false
            font.pixelSize: menuSize
            color: "white"
            text:qsTr("Configure Video")
        }

        Text {
            id: audioSettings
            property bool curSelected: false
            font.pixelSize: menuSize
            color: "white"
            text:qsTr("Configure Audio")
        }

        Text {
            id: aboutHelp
            property bool curSelected: false
            font.pixelSize: menuSize
            color: "white"
            text:qsTr("About / Help")
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

    Keys.onPressed:  {
        if(event.key == Qt.Key_Down) {
            if(sIndex >= indexes.length -1) {
                sIndex =0;
            } else {
                sIndex++;
            }

            event.accepted = true;
            itemActivated(indexToName(sIndex));
            moveSound.play();
        } else if(event.key == Qt.Key_Up) {
            if(sIndex<=0) {
                sIndex = indexes.length - 1;
            } else {
                sIndex--;
            }
            event.accepted = true;
            itemActivated(indexToName(sIndex));
            moveSound.play();
        }
        else if(event.key == Qt.Key_Return) {
            itemSelected((indexToName(sIndex)));
            selectSound.play();
            focus = false;
        }
    }

    Component.onCompleted: {
        itemActivated(indexToName(sIndex));
    }

}

