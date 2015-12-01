function HanoiGame() {
  this.stacks = [[3,2,1],[],[]];
}

HanoiGame.prototype.isWon = function () {
  return this.stacks[0].length === 0 && (this.stacks[1] === 0 ||
          this.stacks[2].length === 0);
};

HanoiGame.prototype.isValidMove = function (startIdx, endIdx) {
  if (startIdx > 2 || startIdx < 0 || endIdx > 2 || endIdx < 0) {
    return false;
  } else if (this.stacks[startIdx].length <= 0) {
    return false;
  } else if (this.stacks[endIdx].length === 0 ){
    return true;
  } else {
    return this.stacks[startIdx][this.stacks[startIdx].length-1]
              < this.stacks[endIdx][this.stacks[endIdx].length-1];
  }
};

HanoiGame.prototype.move = function (startIdx, endIdx) {
  if (this.isValidMove(startIdx, endIdx)) {
    this.stacks[endIdx].push(this.stacks[startIdx].pop());
    return true;
  } else {
    return false;
  }
};

HanoiGame.prototype.print = function () {
  console.log(JSON.stringify(this.stacks));
};



var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

HanoiGame.prototype.promptMove = function (callback) {
  this.print();

  reader.question("From which stack would you like to take a disc?",
    function(startIdx){
      reader.question("Onto which stack would you like to place that disc?",
          function(endIdx){

            var startTower = parseInt(startIdx);
            var endTower = parseInt(endIdx);

            callback(startTower, endTower);
          });
      });
};

HanoiGame.prototype.run = function (completionCallback) {
  this.promptMove(function(st, en){
    var move = this.move(st, en);

    if (!move){
      console.log("Invalid Move- Try again!");
    }

    if(this.isWon()){
      completionCallback();
    } else {
      this.run(completionCallback);
    }
  }.bind(this));

};



var hg = new HanoiGame();

hg.run(function(){
  reader.close();
  console.log("You won!");
});
