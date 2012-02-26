import QtQuick 1.0

Item {
    id: scoreRoot
    width: 400
    height: 34
    property int score: 0;
    property int maxScore: 100;
    property alias text: label.text
    property alias color: scoreBar.color

    function setScore(s)
    {
        if (maxScore < s) {
            maxScoreAnimation.to = maxScore * 2;
            maxScoreAnimation.start();
        }

        scoreAnimation.to = s;
        scoreAnimation.start();
    }

    PropertyAnimation {
        id: scoreAnimation
        target: scoreRoot
        property: "score"
        to: 0
        duration: 200
    }

    PropertyAnimation {
        id: maxScoreAnimation
        target: scoreRoot
        property: "maxScore"
        to: 0
        duration: 200
    }

    Text {
        id: label
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        font.pointSize: 18
    }

    Rectangle {
        id: scoreBorder
        anchors.left: label.right
        anchors.leftMargin: 10
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        radius: 4
        border.width: 2
        border.color: "black"
        color: "transparent"

        Rectangle {
            id: scoreBar
            anchors.left: parent.left
            anchors.leftMargin: parent.border.width / 2
            anchors.top: parent.top
            anchors.topMargin: parent.border.width / 2
            anchors.bottom: parent.bottom
            anchors.bottomMargin: parent.border.width / 2
            width: scoreRoot.score * scoreBorder.width / scoreRoot.maxScore - parent.border.width
            radius: 4
            color: "green"
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            text: scoreRoot.score
            font.pointSize: 18
        }
    }
}
