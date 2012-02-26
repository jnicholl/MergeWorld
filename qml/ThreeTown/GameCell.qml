import QtQuick 1.0
import Globals 1.0

Rectangle {
    id: cell
    color: "transparent"
    property int row;
    property int col;
    property int type;
    property int lastModified;

    property alias imgSource: image.source

    function onEntered() {
        circle.border.width = 2;
    }

    function onExited() {
        circle.border.width = 1;
    }

    CellTypes {
        id: cellTypes
    }

    function handleTypeChange() {
        image.source = cellTypes.getImagePath(type);
        circle.color = cellTypes.getBackgroundColor(type);
    }

    function animateTo(type, duration) {
        typeChangeDelay.duration = duration;
        typeChangeDelay.newType = type;
        morphImage.source = image.source;
        morphImage.opacity = 1
        image.opacity = 0
        cell.type = type;
        handleTypeChange();
        typeChangeDelay.start();
    }

    ParallelAnimation {
        id: typeChangeDelay
        property int newType: CellTypes.Empty
        property int duration
        running: false;
        PropertyAnimation {
            target: morphImage
            property: "opacity"
            to: 0
            duration: typeChangeDelay.duration
        }
        PropertyAnimation {
            target: image
            property: "opacity"
            to: 1
            duration: typeChangeDelay.duration
        }
    }

    onTypeChanged: handleTypeChange();

    Circle {
        id: circle
        smooth: true
        anchors.fill: parent
        border.width: 1
        border.color: Qt.rgba(.35,.17,0)
        color: Qt.rgba(.35,.17,0,0.7)
        Image {
            id: image
            anchors.centerIn: parent
        }
        Image {
            id: morphImage
            anchors.centerIn: parent
            opacity: 0
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered:
            gameArea.handleEnter(cell.row, cell.col);
        onExited:
            gameArea.handleExit(cell.row, cell.col);
        onClicked:
            gameArea.handleClick(cell.row, cell.col);
    }
}
