(function() {
  // 'use strict';
  if (typeof window.Asteroids === "undefined") {
    window.Asteroids = {};
  }
  var Asteroids = window.Asteroids;

  var DIM_X = window.canvas.width;
  var DIM_Y = window.canvas.height;
  var NUM_ASTEROIDS = 20;

  var Game = Asteroids.Game = function () {
    this.asteroids = [];
    this.addAsteroids();
  };

  Game.prototype.step = function () {
    this.moveObjects();
    this.checkCollisions();
  };

  Game.prototype.addAsteroids = function () {
    for (var i = 0; i < NUM_ASTEROIDS; i++) {
      var newAsteroid = new Asteroids.Asteroid(this.randomPosition(), this);
      this.asteroids.push(newAsteroid);
    }
  };

  Game.prototype.randomPosition = function () {
    var x = Math.random() * DIM_X;
    var y = Math.random() * DIM_Y;
    return [x, y];
  };

  Game.prototype.draw = function (ctx) {
    ctx.clearRect(0, 0, DIM_X, DIM_Y);
    this.asteroids.forEach(function(asteroid) {
      asteroid.draw(ctx);
    });
  };

  Game.prototype.moveObjects = function () {
    this.asteroids.forEach(function(asteroid) {
      asteroid.move();
    });
  };

  Game.prototype.wrap = function (pos) {
      return [(pos[0] + DIM_X) % DIM_X, (pos[1] + DIM_Y) % DIM_Y];
  };

  Game.prototype.checkCollisions = function () {
    // body...
    for (var i = 0; i < this.asteroids.length; i++) {
      for (var j = i + 1; j < this.asteroids.length; j++) {
        var ast1 = this.asteroids[i];
        var ast2 = this.asteroids[j];
        if (ast1.isCollidedWith(ast2)) {
          ast1.collideWith(ast2);
        }
      }
    }
  };

  Game.prototype.remove = function (asteroid) {
    var index = this.asteroids.indexOf(asteroid);
    this.asteroids.splice(index, 1);
  };
}());
