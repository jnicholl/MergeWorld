#ifndef CELLTYPES_H
#define CELLTYPES_H

#include <QDeclarativeItem>

class CellTypes : public QDeclarativeItem
{
    Q_OBJECT
    Q_ENUMS(Type)
public:
    explicit CellTypes(QDeclarativeItem *parent = 0);
    enum Type {
        Empty,
        Grass,
        Bush,
        Tree,
        House,
        Mansion,
        Castle,
        Sandpile,
        Sandblock,
        Sandhouse,
        Pyramid,
        Treasure
    };

    Q_INVOKABLE static const QString getImagePath(Type t);
    Q_INVOKABLE static const QString getBackgroundColor(Type t);

signals:

public slots:

};

#endif // CELLTYPES_H
