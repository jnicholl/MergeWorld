import QtQuick 1.0
import Globals 1.0

Item {
    anchors.fill: parent

    CellTypes {
        id: cellTypes
    }

    ListModel {
        id: typeModel
        ListElement {
            name: "Grass"
            type: CellTypes.Grass
            image: "images/grass.png";
            cost: 50
        }
        ListElement {
            name: "Bush"
            type: CellTypes.Bush
            image: "images/bush.png";
            cost: 50
        }
        ListElement {
            name: "Tree"
            type: CellTypes.Tree
            image: "images/tree.png";
            cost: 50
        }
        ListElement {
            name: "House"
            type: CellTypes.House
            image: "images/house.png";
            cost: 50
        }
        ListElement {
            name: "Mansion"
            type: CellTypes.Mansion
            image: "images/mansion.png";
            cost: 50
        }
        ListElement {
            name: "Castle"
            type: CellTypes.Castle
            image: "images/castle.png";
            cost: 50
        }
        ListElement {
            name: "Sandpile"
            type: CellTypes.Sandpile
            image: "images/sandpile.png";
            cost: 50
        }
        ListElement {
            name: "Sandblock"
            type: CellTypes.Sandblock
            image: "images/sandblock.png";
            cost: 50
        }
        ListElement {
            name: "Sandhouse"
            type: CellTypes.Sandhouse
            image: "images/sandhouse.png";
            cost: 50
        }
        ListElement {
            name: "Pyramid"
            type: CellTypes.Pyramid
            image: "images/pyramid.png";
            cost: 50
        }
        ListElement {
            name: "Treasure"
            type: CellTypes.Treasure
            image: "images/treasure.png";
            cost: 500
        }
    }

    Component {
        id: typeDelegate
        Item {
            width: 64; height: 110
            property int cellType: type
            property int typeCost: cost
            Image {
                width: 64
                height: 64
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                source: image
            }

            Text {
                text: name
                anchors.top: parent.top
                anchors.topMargin: 68
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 12
            }

            Text {
                text: cost
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 12
                color: (listView.currentIndex == index)?"black":"yellow"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: listView.currentIndex = index
            }
        }
    }

    GridView {
        id: listView
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width - 80
        anchors.top: parent.top
        anchors.topMargin: 50
        height: parent.height - 100
        cellWidth: 80; cellHeight: 120
        model: typeModel
        delegate: typeDelegate
        highlight: Rectangle { color: "yellow"; radius: 5 }
        focus: true
    }

    Item {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        width: 350
        height: cancel.height

        Rectangle {
            id: buy
            border.width: 1
            border.color: "black"
            anchors.left: parent.left
            width: 160
            height: buyLabel.height + 5
            radius: 4

            color: "yellow"

            Text {
                id: buyLabel
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                text: "Buy Selected"
                font.pointSize: 20
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: parent.border.width += 1;
                onExited: parent.border.width -= 1;
                onClicked: {
                    if (gameArea.buyItem(listView.currentItem.cellType, listView.currentItem.typeCost))
                        storeScreen.opacity = 0;
                }
            }
        }

        Rectangle {
            id: cancel
            border.width: 1
            border.color: "black"
            anchors.right: parent.right
            width: 160
            height: cancelLabel.height + 5
            radius: 4

            color: "yellow"

            Text {
                id: cancelLabel
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                text: "Cancel"
                font.pointSize: 20
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: parent.border.width += 1;
                onExited: parent.border.width -= 1;
                onClicked: storeScreen.opacity = 0;
            }
        }
    }
}
