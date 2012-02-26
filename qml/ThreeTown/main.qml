import QtQuick 1.0

Rectangle {
    id: window

    width: 1024
    height: 600

    function showMenu() {
        menuScreen.opacity = 1;
    }

    function showStore() {
        storeScreen.opacity = 1;
    }

    Image {
        anchors.fill: parent
        source: "images/background.png"
    }

    MenuBar {
        id: menuBar
    }

    GameArea {
        id: gameArea
        anchors.top: menuBar.bottom
        anchors.topMargin: 20
        anchors.leftMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
    }

//    StatusBar {
//        id: statusBar
//    }

    Component {
        id: storeScreenContents
        StoreScreen {}
    }

    Screen {
        id: storeScreen
        anchors.fill: parent
        opacity: 0
        contents: storeScreenContents
    }

    Component {
        id: menuScreenContents
        MenuScreen {}
    }

    Screen {
        id: menuScreen
        anchors.fill: parent
        opacity: 1
        contents: menuScreenContents
    }
}
