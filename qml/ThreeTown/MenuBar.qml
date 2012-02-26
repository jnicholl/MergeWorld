import QtQuick 1.0
import Globals 1.0

Rectangle {
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.top: parent.top
    height: 88;
    color: "transparent"

    function setScore(s)
    {
        score.setScore(s);
    }

    function setMoney(m)
    {
        money.setScore(m);
    }

    function setNextType(type)
    {
        currentItemImage.source = cellTypes.getImagePath(type);
    }

    function setStashType(type)
    {
        stashImage.source = cellTypes.getImagePath(type);
    }

    Image {
        anchors.fill: parent
        source: "images/topbar.png"
    }

    ScoreWidget {
        id: score
        text: "Score"
        anchors.left: parent.left
        anchors.leftMargin: 30
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        width: 400
        height: 34
        color: "green"
    }

    ScoreWidget {
        id: money
        text: "Money"
        anchors.right: parent.right
        anchors.rightMargin: 30
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        width: 400
        height: 34
        color: "yellow"
    }

    CellTypes {
        id: cellTypes
    }

    Rectangle {
        id: menuButton
        anchors.right: middleIcons.left
        anchors.rightMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 5

        width: 128
        height: 34
        radius: 8
        border.width: 1
        border.color: "black"

        color: "yellow"

        Text {
            id: menuButtonLabel
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.pointSize: 14
            text: "Back to Menu"
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: parent.border.width = 2;
            onExited: parent.border.width = 1;
            onClicked: window.showMenu();
        }
    }

    Rectangle {
        id: storeButton
        anchors.left: middleIcons.right
        anchors.leftMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 5

        width: 128
        height: 34
        radius: 8
        border.width: 1
        border.color: "black"

        color: "yellow"

        Text {
            id: storeButtonLabel
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.pointSize: 14
            text: "Store"
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered: parent.border.width = 2;
            onExited: parent.border.width = 1;
            onClicked: window.showStore();
        }
    }

    Item {
        id: middleIcons
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        width: 150
        height: parent.height
        Rectangle {
            id: currentItem
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            width: 72
            height: 72
            radius: 4
            border.color: "black"
            border.width: 2
            color: "transparent"
            Image {
                id: currentItemImage
                smooth: true
                anchors.fill: parent
                source: "images/grass.png"
            }
        }

        Rectangle {
            id: stash
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            width: 72
            height: 72
            radius: 4
            border.color: "black"
            border.width: 2
            color: "transparent"
            Image {
                id: stashImage
                smooth: true
                anchors.fill: parent
                source: ""
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: parent.border.width += 1;
                onExited: parent.border.width -= 1;
                onClicked: gameArea.stashClicked();
            }
        }
    }
}
