import QtQuick 1.0
import Globals 1.0
import "game.js" as Game

Rectangle {
    id: gameArea
    anchors.left: parent.left
    anchors.right: parent.right
    color: "transparent"

    Component.onCompleted:
        Game.createCells(gameArea.width, gameArea.height)

    function handleEnter(row, col)
    {
        Game.handleEnter(row, col);
    }

    function handleExit(row, col)
    {
        Game.handleExit(row, col);
    }

    function handleClick(row, col)
    {
        Game.handleClick(row, col);
    }

    function stashClicked()
    {
        Game.handleStashClick();
    }

    function buyItem(type, cost)
    {
        return Game.buyItem(type, cost);
    }
}
