#include "celltypes.h"

CellTypes::CellTypes(QDeclarativeItem *parent) :
    QDeclarativeItem(parent)
{
}

const QString CellTypes::getImagePath(Type t)
{
    switch (t)
    {
    case Empty:
        return "";
    case Grass:
        return "images/grass.png";
    case Bush:
        return "images/bush.png";
    case Tree:
        return "images/tree.png";
    case House:
        return "images/house.png";
    case Mansion:
        return "images/mansion.png";
    case Castle:
        return "images/castle.png";
    case Sandpile:
        return "images/sandpile.png";
    case Sandblock:
        return "images/sandblock.png";
    case Sandhouse:
        return "images/sandhouse.png";
    case Pyramid:
        return "images/pyramid.png";
    case Treasure:
        return "images/treasure.png";
    default:
        return "";
    }
}

const QString CellTypes::getBackgroundColor(Type t)
{
    switch (t)
    {
    case Empty:
        return "#B2592C00";
    case Sandpile:
    case Sandblock:
    case Sandhouse:
    case Pyramid:
        return "#50FF8000";
    default:
        return "transparent";
    }
}
