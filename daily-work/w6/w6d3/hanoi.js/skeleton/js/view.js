function View (game, $el) {
  this.game = game;
  this.$el = $el;
  this.setUpTowers();
  this.setUpHandlers();
  this.clicked = false;
  this.$fromStack;
};

View.prototype.setUpTowers = function () {
  var $stack;

  for (var i = 0; i < 3; i++) {
    $stack = $("<ul>").data('idx', i);
    for (var j = 0; j < 3; j++) {
      $stack.append($("<li>"));
    }
    this.$el.append($stack);
  }
  this.render();
};

View.prototype.setUpHandlers = function () {
  this.$el.on('click', 'ul', this.handleClick.bind(this));
};

View.prototype.handleClick = function (e) {
  var $currentStack = $(e.currentTarget);
  if (this.clicked) {
    this.game.move(
      $fromStack.data('idx'),
      $currentStack.data('idx')
    );

    if (this.game.isWon()) {
      console.log("winner");
      $('ul').addClass('game-over');
      $('li').addClass('game-over');
    }
  } else {
    $fromStack = $currentStack;
  }
  this.clicked = !this.clicked;
  console.log(this.game.towers);
  this.render();
};


View.prototype.render = function () {
  var gameTowers = this.game.towers;
  var $towers = this.$el.find("ul");

  for (var i = 0; i < 3; i++) {
    for (var j = 0; j < 3; j++) {
      var $tower = $towers.eq(i).find("li");
      var diskNum = gameTowers[i][j];

      $tower.eq(2 - j).removeClass();

      if (diskNum !== undefined) {
        $tower.eq(2 - j).addClass("disk-" + diskNum);
      }
    }
  }
};


module.exports = View;
