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

    ListView {
        id: gameListView
        model: root.gameNameList
        currentIndex: 0
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.height
        spacing: root.height / 50
        delegate: Item {
            height: root.height / 10
            width: gameImage.width + gameText.width + (height/5);
            Image {
                id: gameImage;
                source:"image://gameimg/" + index;
                fillMode: Image.PreserveAspectFit;
                anchors.top: parent.top
                anchors.topMargin: parent.height /10
                anchors.left: parent.left
                anchors.leftMargin: parent.height / 10
                anchors.bottom: parent.bottom
                anchors.bottomMargin: parent.height/10
            }
            Text {
                id: gameText
                text: modelData;
                color:"white";
                font.pixelSize: parent.height * .9
                verticalAlignment: Text.AlignVCenter
                anchors.left: gameImage.right
                //anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.bottomMargin: parent.height/10
                anchors.top: parent.top
                anchors.topMargin: parent.height /10
            }
        }

        highlight: Rectangle {
            color:"#00AAFF"
            opacity:isSelected ? .75 : .25
            radius: 5
            width: gameListView.currentItem.width
            height: gameListView.currentItem.height
            x: gameListView.currentItem.x
            y: gameListView.currentItem.y
            Behavior on y{
                NumberAnimation {
                    easing.type : Easing.OutBack
                    duration: 300
                }
            }
            Behavior on width{
                NumberAnimation {
                    duration: 300
                }
            }
            Behavior on opacity {
                NumberAnimation {
                    duration: 300
                }
            }
        }
        highlightFollowsCurrentItem: false
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
        if(gameListView.currentIndex==0) {
            gameListView.currentIndex = gameListView.count-1;
        } else {
            gameListView.currentIndex = gameListView.currentIndex-1;
        }
        moveSound.play();
    }

    function handleDown() {
        if(gameListView.currentIndex == gameListView.count -1) {
            gameListView.currentIndex =0;
        } else {
            gameListView.currentIndex = gameListView.currentIndex+1;
        }
        moveSound.play();
    }


    function handleLeft() {

    }

    function handleRight() {

    }

    function handleSelect() {
        cppMainWin.playGame(gameListView.currentIndex);
    }

    function handleBack() {

    }
}

