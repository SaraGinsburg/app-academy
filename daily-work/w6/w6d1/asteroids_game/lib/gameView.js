(function() {

  if (typeof window.Asteroids === "undefined") {
    window.Asteroids = {};
  }
  var Asteroids = window.Asteroids;

  var GameView = Asteroids.GameView = function(game, ctx) {
    this.game = game;
    this.ctx = ctx;
  };

  GameView.prototype.start = function () {
    setInterval(function() {
      this.game.step();
      this.game.draw(this.ctx);
    }.bind(this), 20);
  };

}());
