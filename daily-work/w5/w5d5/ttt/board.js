function Board (){
  this.grid = [[" ", " ", " "],
              [" ", " ", " "],
              [" ", " ", " "]];
}

Board.prototype.won = function () {
  return this.winner() === null;
  // return this.verticalWon() || this.horizontalWon() || this.diagonalWon();
};

Board.prototype.horizontalWon = function(tile){
  for (var i = 0; i < this.grid.length; i++) {
    var row = this.grid[i];
    if ((row[0] === tile) && (row[1] === tile) && (row[2] === tile)) {
      return true;
    }
  }
  return false;
};

Board.prototype.verticalWon = function(tile){
  for (var i = 0; i < this.grid.length; i++) {
    if ( this.grid[0][i] === tile &&
         this.grid[1][i] === tile &&
         this.grid[2][i] === tile)
         {
          return true;
    }
  }
  return false;
};

Board.prototype.diagonalWon = function(tile){
  var rightDiag = this.grid[0][0] === tile &&
                  this.grid[1][1] === tile &&
                  this.grid[2][2] === tile;


  var leftDiag = this.grid[0][2] === tile &&
                 this.grid[1][1] === tile &&
                 this.grid[2][0] === tile;
  return rightDiag || leftDiag;
};

Board.prototype.winner = function () {
  ["x", "o"].forEach(function (tile){
    if (this.diagonalWon(tile) || this.horizontalWon(tile) || this.verticalWon(tile)){
      return tile;
    }
  });
  return null;
};

Board.prototype.empty = function (xPos, yPos) {
  if (xPos > 2 || xPos < 0 || yPos > 2 || yPos < 0) {
    return false;
  }
  this.getSlot(xPos, yPos) === " ";
};

Board.prototype.getSlot = function (xPos, yPos) {
  return this.grid[xPos][yPos];
};

Board.prototype.setSlot = function (xPos, yPos, tile) {
  this.grid[xPos][yPos] = tile;
};

Board.prototype.print = function () {
  for (var i = 0; i < this.grid.length; i++) {
    var row = this.grid[i];
    console.log(JSON.stringify(row));
  }
};

module.exports = Board;
