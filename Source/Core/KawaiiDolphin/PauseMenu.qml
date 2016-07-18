import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: root
    width: 100
    height: 100
    focus: true

    Image {
        id: back
        source:"image://screen/1";
        anchors.fill: parent
    }

    FastBlur {
        id: blur
        anchors.fill: back
        source: back
        radius: 0
        Behavior on radius {
            NumberAnimation  {
                duration: 1000
            }
        }
    }


    ListModel {
        id: optionModel
        ListElement {
            name: "The first option"
        }
        ListElement {
            name: "Option #2"
        }
        ListElement {
            name: "Some third option"
        }
        ListElement {
            name: "Back to the game!"
        }
    }

    Component {
        id: optionDel
        Item {
            height: textItem.height
            width: root.width /2
            Text {
                id: textItem
                font.pointSize: 24
                text: name
                color: "white"
                style: Text.Outline;
                styleColor: "black"
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }

    Component {
        id: highlight
        Rectangle {
//            width: 180; height: 40
            color: "lightsteelblue"; radius: 5
//            y: list.currentItem.y
//            Behavior on y {
//                SpringAnimation {
//                    spring: 3
//                    damping: 0.2
//                }
//            }
        }
    }

    ListView {
        id:list
        model: optionModel
        width: parent.width/2
        height: parent.height/2
        anchors.centerIn: parent
        delegate: optionDel
        opacity: 0
        Component.onCompleted: {
            opacity = 1
        }
        Behavior on opacity {
            NumberAnimation  {
                duration: 1000
            }
        }
        highlight: highlight
        highlightFollowsCurrentItem: true
        keyNavigationWraps: true


    }


    Keys.onPressed:  {
        if(event.key == Qt.Key_Down) {
            list.incrementCurrentIndex();
        } else if(event.key == Qt.Key_Up) {
            list.decrementCurrentIndex();
        } else if(event.key == Qt.Key_Return) {
            console.debug("Enter!");
            cppMainWin.handleEscapePressed();
        }
    }


    Component.onCompleted: {
        blur.radius=50
    }

}

