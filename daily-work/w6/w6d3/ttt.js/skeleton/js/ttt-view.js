var View = function (game, $el) {
  this.$el = $el;
  console.log(game);
  this.game = game;
  this.setUpBoard();
  this.bindEvents();
};

View.prototype.bindEvents = function () {
  this.$el.on('click', '.square', this.makeMove.bind(this));
};

View.prototype.makeMove = function (e) {
  //register move
  var mark = this.game.currentPlayer.toUpperCase();
  var $currentSquare = $(e.currentTarget);
  console.log($currentSquare);
  var pos = $currentSquare.data('pos');
  console.log(pos);
  this.game.playMove(pos);

  //display move
  $currentSquare.addClass("marked").append(mark);

  if(this.game.isOver()){
    if (this.game.winner()) {
      alert(mark + " wins the GAME!!!!!!!!");
    } else {
      alert("You both lose");
    }

  }
};

View.prototype.setUpBoard = function () {
  var $boardList = $("<ul>").addClass("board-list").addClass("group");

  for (var i = 0; i < 3; i++) {
    for (var j = 0; j < 3; j++) {
      $boardList.append($("<li>").addClass("square").data('pos',[i,j]));
    }
  }


  this.$el.append($boardList);
};

module.exports = View;
