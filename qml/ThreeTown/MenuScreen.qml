import QtQuick 1.0

Item {
    anchors.fill: parent
    Text {
        id: logo
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 60
        font.pointSize: 40
        text: "Logo Goes Here"
    }

    Rectangle {
        id: startGame
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: logo.bottom
        anchors.topMargin: 120
        border.width: 1
        border.color: "black"
        width: 160
        height: startGameLabel.height + 5
        radius: 4

        color: "yellow"

        Text {
            id: startGameLabel
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: "Start Game"
            font.pointSize: 20
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: parent.border.width += 1;
            onExited: parent.border.width -= 1;
            onClicked: menuScreen.opacity = 0;
        }
    }

    Rectangle {
        id: tutorial
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: startGame.bottom
        anchors.topMargin: 20
        border.width: 1
        border.color: "black"
        width: 160
        height: tutorialLabel.height + 5
        radius: 4

        color: "yellow"

        Text {
            id: tutorialLabel
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: "Tutorial"
            font.pointSize: 20
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: parent.border.width += 1;
            onExited: parent.border.width -= 1;
        }
    }

    Rectangle {
        id: editor
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: tutorial.bottom
        anchors.topMargin: 20
        border.width: 1
        border.color: "black"
        width: 160
        height: editorLabel.height + 5
        radius: 4

        color: "yellow"

        Text {
            id: editorLabel
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: "Level Editor"
            font.pointSize: 20
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: parent.border.width += 1;
            onExited: parent.border.width -= 1;
        }
    }

    Rectangle {
        id: quit
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: editor.bottom
        anchors.topMargin: 20
        border.width: 1
        border.color: "black"
        width: 160
        height: startGameLabel.height + 5
        radius: 4

        color: "yellow"

        Text {
            id: quitLabel
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: "Exit Game"
            font.pointSize: 20
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: parent.border.width += 1;
            onExited: parent.border.width -= 1;
            onClicked: Qt.quit();
        }
    }
}
