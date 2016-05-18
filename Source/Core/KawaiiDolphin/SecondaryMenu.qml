import QtQuick 2.0

Rectangle {
    property bool isSelected: false
    border.width: parent.width / 500
    border.color: "grey"
    color: "transparent"
    radius: parent.width / 500

    function updateInteral(newMenu) {
        if(newMenu == "configControl") {
            pageLoader.source = "qrc:/qml/ConfigControler.qml"
        }
        else if(newMenu == "selectGame")  {
            pageLoader.source = ""
        } else if(newMenu == "configAudio") {
            pageLoader.source = ""
        } else if(newMenu == "configVideo") {
            pageLoader.source = ""
        }

        //console.debug(newMenu);
    }

    Loader {
        anchors.fill: parent
        id: pageLoader
    }




}

