(function() {
  // 'use strict';
  if (typeof window.Asteroids === "undefined") {
    window.Asteroids = {};
  }
  var Asteroids = window.Asteroids;
  var Util = Asteroids.Util = {};

  Util.inherits = function (ChildClass, ParentClass) {
    var Surrogate = function() {};

    Surrogate.prototype = ParentClass.prototype;
    ChildClass.prototype = new Surrogate();
    ChildClass.prototype.constructor = ChildClass;
  };

  Util.randomVec = function(length) {
    var sine = Math.sin(2 * Math.PI * Math.random());
    var x = length * sine;
    var y = Math.sqrt(Math.pow(length, 2) - Math.pow(x, 2));
    return [x, y];
  };

}());
