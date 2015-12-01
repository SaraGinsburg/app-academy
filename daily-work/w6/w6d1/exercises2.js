// var Surrogate = function() {};
// var SuperClass = function() {};
// var Subclass = function() {};
//
// Surrogate.prototype = SuperClass.prototype;
// Subclass.prototype = new Surrogate();
// //Subclass.prototype.constructor == new SuperClass();
// Subclass.prototype.constructor = Subclass;




//surrogate == surrogate
//this == Subclass
//superClass == superClass
Function.prototype.inherits = function(superClass) {
  var Surrogate = function() {};
  var SubClass = this;

  Surrogate.prototype = superClass.prototype;
  SubClass.prototype = new Surrogate();
  SubClass.prototype.constructor = SubClass;
};
