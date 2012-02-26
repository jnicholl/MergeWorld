var cellSize = 48;
var cellDiff = cellSize * 0.5 * Math.sqrt(3);
var numPerRow = 1;
var numRows = 1;
var cells;
var component;
var mergeComponent;

var gameTime = 0;
var score = 0;
var money = 0;

var deferredType = CellTypes.Empty;
var nextType = generateNextType();
var stashType = CellTypes.Empty;

function createCells(width, height) {
    numRows = Math.floor(height / cellDiff);
    numPerRow = Math.floor(width / cellSize);
    if (component == null) {
        component = Qt.createComponent("GameCell.qml");
    }

    if (component.status != Component.Ready) {
        console.log("Error loading GameCell component");
        console.log(component.errorString());
        return false;
    }

    if (mergeComponent == null) {
        mergeComponent = Qt.createComponent("MergeAnimator.qml");
    }

    if (mergeComponent.status != Component.Ready) {
        console.log("Error loading MergeAnimator component");
        console.log(mergeComponent.errorString());
        return false;
    }

    cells = new Array(numRows);
    for (var i=0; i<numRows; i+=2) {
        createShortRow(i);
        if (i+1 < numRows)
            createNormalRow(i+1);
    }

    return true;
}

function createCell(x,y)
{
    var obj = component.createObject(gameArea);
    if (obj === null) {
        console.log("Error creating GameCell");
        console.log(component.errorString());
        return null;
    }
    obj.x = x;
    obj.y = y;
    obj.width = cellSize;
    obj.height = cellSize;
    obj.lastModified = gameTime;
    obj.type = 0; // EMPTY
    return obj;
}

function createNormalRow(row) {
    cells[row] = new Array(numPerRow);
    cells[row].isShort = false;
    for (var i=0; i<numPerRow; i++) {
        var obj = createCell(i*cellSize, row*cellDiff);
        if (obj === null) {
            return false;
        }
        obj.row = row;
        obj.col = i;
        cells[row][i] = obj;
    }
    return true;
}

function createShortRow(row) {
    cells[row] = new Array(numPerRow-1);
    cells[row].isShort = true;
    for (var i=0; i<numPerRow-1; i++) {
        var obj = createCell(i*cellSize + cellSize/2, row*cellDiff);
        if (obj === null) {
            return false;
        }
        obj.row = row;
        obj.col = i;
        cells[row][i] = obj;
    }
    return true;
}

function handleEnter(row, col) {
    cells[row][col].onEntered();
//    visitNeighbours(row, col,
//                    function(row, col) {
//                        cells[row][col].onEntered();
//                    }
//    );
}

function handleExit(row, col) {
    cells[row][col].onExited();
//    visitNeighbours(row, col,
//                    function(row, col) {
//                        cells[row][col].onExited();
//                    }
//    );
}

function buyItem(type, cost) {
    if (cost <= money) {
        incrementMoney(-cost);
        deferredType = nextType;
        nextType = type;
        menuBar.setNextType(nextType);
        return true;
    }
    return false;
}

function generateNextType() {
    if (deferredType != CellTypes.Empty) {
        nextType = deferredType;
        deferredType = CellTypes.Empty;
    } else {
        var r = Math.random() * 100;
        if (r < 40) {
            nextType = CellTypes.Grass;
        } else if (r < 70) {
            nextType = CellTypes.Sandpile;
        } else if (r < 85) {
            nextType = CellTypes.Sandblock;
        } else if (r < 99) {
            nextType = CellTypes.Bush;
        } else {
            nextType = CellTypes.Tree;
        }
    }
    nextType = CellTypes.Treasure;
    menuBar.setNextType(nextType);
    return nextType;
}

function handleStashClick() {
    if (stashType != CellTypes.Empty) {
        var tmp = nextType;
        nextType = stashType;
        stashType = tmp;
        menuBar.setStashType(stashType);
        menuBar.setNextType(nextType);
    } else {
        stashType = nextType;
        menuBar.setStashType(stashType);
        generateNextType();
    }
}

function handleClick(row, col) {
    gameTime++;
    switch (cells[row][col].type) {
    case CellTypes.Empty:
        cells[row][col].type = nextType;
        incrementScore(getScoreForUpgrade(nextType));
        break;
    case CellTypes.Treasure:
        cells[row][col].type = CellTypes.Empty;
        incrementMoney(100);
        break;
    default:
        return;
    }

    cells[row][col].lastModified = gameTime;
    checkDoMerge(row, col);
    checkEnd();
    generateNextType();
}

function checkEnd()
{
    for (var i=0; i<cells.length; i++) {
        for (var j=0; j<cells[i].length; j++) {
            if (cells[i][j].type == CellTypes.Empty) {
                return;
            }
        }
    }

    for (var i=0; i<cells.length; i++) {
        for (var j=0; j<cells[i].length; j++) {
            cells[i][j].type = CellTypes.Empty;
        }
    }
    showMenu(); // TODO: Show loss and score
}

function checkDoMerge(row, col) {
    var type = cells[row][col].type;
    if (type == CellTypes.Empty)
        return;
    checkDoMergeHelper(row, col, type);
}

function checkDoMergeHelper(row, col, type) {
    var newest = cells[row][col];
    var lastModified = newest.lastModified;
    var a = new Array();

    var dfs = function(row, col) {
        var thisCell = cells[row][col];
        if (thisCell.type == type && a.indexOf(thisCell) == -1) {
            if (thisCell.lastModified > lastModified) {
                newest = thisCell;
                lastModified = newest.lastModified;
            }
            a.push(thisCell);
            visitNeighbours(row, col, dfs);
        }
    };
    a.push(cells[row][col]);
    visitNeighbours(row, col, dfs);

    if (a.length >= 4) {
        for (var i=0; i<a.length; i++) {
            if (a[i] == newest)
                continue;
            var obj = mergeComponent.createObject(gameArea);
            if (obj === null) {
                console.log("Error creating merge component");
                console.log(component.errorString());
            } else {
                obj.x = a[i].x;
                obj.y = a[i].y;
                obj.width = a[i].width;
                obj.height = a[i].height;
                obj.targetX = newest.x;
                obj.targetY = newest.y;
                obj.image = a[i].imgSource;
                obj.startAnimation(); // lasts 1100 ms
            }

            a[i].type = CellTypes.Empty;
        }

        var upgrade = getUpgradeType(type);
        newest.animateTo(upgrade, 1100);
        incrementScore(getScoreForUpgrade(upgrade));
        if (upgrade != CellTypes.Treasure) // Treasure does not upgrade
            checkDoMergeHelper(newest.row, newest.col, upgrade);
    }
}

function incrementScore(inc)
{
    score += inc;
    menuBar.setScore(score);
}

function incrementMoney(inc)
{
    money += inc;
    menuBar.setMoney(money);
}

function getScoreForUpgrade(type)
{
    switch (type)
    {
    case CellTypes.Empty: return 0;
    case CellTypes.Grass: return 5;
    case CellTypes.Bush: return 10;
    case CellTypes.Tree: return 20;
    case CellTypes.House: return 50;
    case CellTypes.Mansion: return 100;
    case CellTypes.Castle: return 200;
    case CellTypes.Sandpile: return 5;
    case CellTypes.Sandblock: return 10;
    case CellTypes.Sandhouse: return 50;
    case CellTypes.Pyramid: return 100;
    case CellTypes.Treasure: return 200;
    default: return 0;
    }
}

function getUpgradeType(type)
{
    switch (type)
    {
    case CellTypes.Grass:
        return CellTypes.Bush;
    case CellTypes.Bush:
        return CellTypes.Tree;
    case CellTypes.Tree:
        return CellTypes.House;
    case CellTypes.House:
        return CellTypes.Mansion;
    case CellTypes.Mansion:
        return CellTypes.Castle;
    case CellTypes.Castle:
        return CellTypes.Treasure;
    case CellTypes.Sandpile:
        return CellTypes.Sandblock;
    case CellTypes.Sandblock:
        return CellTypes.Sandhouse;
    case CellTypes.Sandhouse:
        return CellTypes.Pyramid;
    case CellTypes.Pyramid:
        return CellTypes.Treasure;
    case CellTypes.Treasure:
        return CellTypes.Treasure;
    default:
        return CellTypes.Empty;
    }
}

function visitNeighbours(row, col, callback)
{
    // 6 possible values
    if (cells[row].isShort) {
        if (row > 0) {
            callback(row-1, col);
            if (col < cells[row-1].length-1) {
                callback(row-1, col+1);
            }
        }

        if (col > 0) {
            callback(row, col-1);
        }

        if (col < cells[row].length-1) {
            callback(row, col+1);
        }

        if (row+1 < numRows) {
            callback(row+1, col);
            if (col < cells[row+1].length-1) {
                callback(row+1, col+1);
            }
        }
    } else {
        if (row > 0) {
            if (col < cells[row-1].length) {
                callback(row-1, col);
            }
            if (col > 0) {
                callback(row-1, col-1);
            }
        }

        if (col > 0) {
            callback(row, col-1);
        }

        if (col < cells[row].length-1) {
            callback(row, col+1);
        }

        if (row+1 < numRows) {
            if (col < cells[row+1].length) {
                callback(row+1, col);
            }
            if (col > 0) {
                callback(row+1, col-1);
            }
        }
    }
}
