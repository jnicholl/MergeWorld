import QtQuick 1.0

Rectangle {
    id: animator
    property int targetX
    property int targetY
    property alias image: img.source

    color: "transparent"

    function startAnimation() {
        animation.start();
    }

    Image {
        id: img
        anchors.centerIn: parent
    }

    SequentialAnimation {
        id: animation
        running: false
        ParallelAnimation {
            NumberAnimation {
                target: animator
                properties: "x"
                to: targetX
                duration: 500
            }
            NumberAnimation {
                target: animator
                properties: "y"
                to: targetY
                duration: 500
            }
        }
        NumberAnimation {
            target: animator;
            property: "opacity";
            to: 0;
            duration: 100
        }

        onRunningChanged: if (!running) { animator.destroy(); }
    }
}
