import QtQuick 1.0

Rectangle {
    color: Qt.rgba(1, 1, 1, 0.2)
    property alias contents: contents.sourceComponent

    MouseArea {
        anchors.fill: parent
    }

    Rectangle {
        id: screenBody
        width: 800
        height: 512
        y: -512
        radius: 10
        anchors.horizontalCenter: parent.horizontalCenter

        color: Qt.rgba(0.34, 0.17, 0)

        Loader {
            id: contents
            anchors.fill: parent
        }
    }

    states: [
        State {
            name: "shown"; when: opacity == 1
            PropertyChanges { target: screenBody; y: 0; }
        },
        State {
            name: "hidden"; when: opacity == 0
            PropertyChanges { target: screenBody; y: -512; }
        }
    ]
    state: "shown"

    transitions:
        Transition {
            NumberAnimation { properties: "y"; duration: 200; }
        }
}
