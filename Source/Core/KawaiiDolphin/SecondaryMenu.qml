import QtQuick 2.0

Rectangle {
    property bool isSelected: false
    border.width: parent.width / 500
    border.color: "grey"
    color: "transparent"
    radius: parent.width / 500
    focus: isSelected

    property bool wasSelectPushedBefore: false;
    property bool wasUpPushedBefore: false;
    property bool wasDownPushedBefore: false;

    signal goBack();

    function updateInteral(newMenu) {
        if(newMenu == "configControl") {
            pageLoader.source = "qrc:/qml/ConfigControler.qml"
        }
        else if(newMenu == "selectGame")  {
            pageLoader.source = "qrc:/qml/SelectGame.qml"
        } else if(newMenu == "configAudio") {
            pageLoader.source = ""
        } else if(newMenu == "configVideo") {
            pageLoader.source = ""
        } else if(newMenu == "helpAbout") {

        }

        //console.debug(newMenu);
    }

    onIsSelectedChanged: {
        pageLoader.item.isSelected = isSelected;

    }

    Loader {
        id: pageLoader
        anchors.fill: parent
        anchors.leftMargin: parent.border.width * 2;
        anchors.rightMargin: parent.border.width * 2;
        anchors.topMargin: parent.border.width * 2;
        anchors.bottomMargin:  parent.border.width * 2;
    }

    Keys.onPressed:  {
        if(event.key == Qt.Key_Down) {
            pageLoader.item.handleDown();
        } else if(event.key == Qt.Key_Up) {
            pageLoader.item.handleUp();
        } else if(event.key == Qt.Key_Return) {
            pageLoader.item.handleSelect();

        } else if(event.key == Qt.Key_Backspace) {
            isSelected = false;
            secondMenu.goBack();
        }
    }

    function handleUpState( newVal) {
        if(!focus) {
            return;
        }

        if(newVal == 1) {
            wasUpPushedBefore = true;
        } else if(newVal == 0 && wasUpPushedBefore) {
            pageLoader.item.handleUp();
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
            pageLoader.item.handleDown();
        }
    }

    function handleSelectState( newVal) {
        if(!focus) {
            return;
        }


        if(newVal == 1) {
            wasSelectPushedBefore = true;
        } else if(newVal == 0 && wasSelectPushedBefore) {
            pageLoader.item.handleSelect();
        }
    }

}

