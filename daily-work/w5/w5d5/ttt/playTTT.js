var TTT = require("./index");

var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var game = new TTT.Game(reader);
game.run(function(turn) {
  console.log(turn + " won!");
  reader.close();
});
