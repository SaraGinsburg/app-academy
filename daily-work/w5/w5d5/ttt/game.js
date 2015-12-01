var Board = require("./board");
function Game(reader) {
  this.board = new Board();
  this.reader = reader;
}

Game.prototype.run = function (completionCallback) {
  var turn = "x";
  while (!this.board.won()) {
    this.move(turn);
  }
  completionCallback(turn);
}.bind(this);

Game.prototype.move = function (turn) {
  this.print();
  console.log("It is " + turn + "'s turn");
  this.reader.question("Where would you like to place your tile?",
    function(tilePos) {
      var pos = tilePos.split(",");
      var xPos = parseInt(pos[0]);
      var yPos = parseInt(pos[1]);
      if (this.board.empty(xPos, yPos)) {
        this.board.setSlot(xPos, yPos, turn);
        if (turn === "x"){
          turn = "o";
        } else {
          turn = "x";
        }
      } else {
        console.log("Invalid move, already a tile there!");
      }
  });
}.bind(this);

module.exports = Game;
