(function() {
  // 'use strict';

  if (typeof window.Asteroids === "undefined") {
    window.Asteroids = {};
  }
  var Asteroids = window.Asteroids;


  var MovingObject = Asteroids.MovingObject =  function(args) {
    console.log(args);
    this.game = args.game;
    this.pos = args.pos;
    this.vel = args.vel;
    this.radius = args.radius;
    this.color = args.color;
  };

  MovingObject.prototype.draw = function(ctx) {
    ctx.fillStyle = this.color;
    ctx.beginPath();
    ctx.arc(this.pos[0], this.pos[1], this.radius, 0, 2 * Math.PI);
    ctx.closePath();
    ctx.fill();
    ctx.stroke();
  };

  MovingObject.prototype.move = function () {
    this.pos[0] += this.vel[0];
    this.pos[1] += this.vel[1];
    this.pos = this.game.wrap(this.pos);
  };

  MovingObject.prototype.isCollidedWith = function (other) {
    var xDiff = this.pos[0] - other.pos[0];
    var yDiff = this.pos[1] - other.pos[1];
    var distance = Math.sqrt(Math.pow(xDiff, 2) + Math.pow(yDiff, 2));

    var radiiSum = this.radius + other.radius;

    return distance < radiiSum;
  };

  MovingObject.prototype.collideWith = function (other) {
    this.game.remove(this);
    this.game.remove(other);
  };

}());
