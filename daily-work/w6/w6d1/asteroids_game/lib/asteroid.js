(function() {
  // 'use strict';
  if (typeof window.Asteroids === "undefined") {
    window.Asteroids = {};
  }
  var Asteroids = window.Asteroids;

  var COLOR = "#800000";
  var RADIUS = 15;

  var Asteroid = Asteroids.Asteroid =  function (pos, game) {
    var args = {};

    args.pos = pos;
    args.game = game;
    args.color = COLOR;
    args.radius = RADIUS;
    args.vel = Asteroids.Util.randomVec(1); //figure out length at some point

    Asteroids.MovingObject.call(this, args);
  };


  Asteroids.Util.inherits(Asteroid, Asteroids.MovingObject);

}());
