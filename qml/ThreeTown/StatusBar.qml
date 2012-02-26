import QtQuick 1.0

Rectangle {
    id: statusBar_root
    anchors.bottom: parent.bottom
    anchors.left: parent.left
    anchors.right: parent.right
    height: 30
    property alias text: label.text

    color: "darkgray"

    Text {
        id: label
        text: "Status here"
    }
}
