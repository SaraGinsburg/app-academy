Array.prototype.myEach = function(func){
  for (var i = 0; i < this.length; i++) {
    func(this[i]);
  }
  return this;
}

var arr = [1,2,3];

// console.log(arr.myEach(function(el){
//   console.log(el * el);
// }));
//
// console.log(arr.myEach(function(el){
//   console.log(el.toString());
// }));
//
// console.log(arr.myEach(function(el){
//   console.log(el + 5);
// }));

Array.prototype.myMap = function(func){
  var result = [];

  var fxn = function(x) {
    result.push(func(x));
  }

  this.myEach(fxn);

  return result;
}

// console.log(arr.myMap(function(x){
//   return x * x;
// }));
//
// console.log(arr.myMap(function(x){
//   return "" + x + "th";
// }));


Array.prototype.myInject = function (fxn) {
  var accumulator = this[0];

  var f = function(x) {
    accumulator = fxn(accumulator, x);
  }

  var currentArray = this.slice(1, this.length);
  currentArray.myEach(f);

  return accumulator;
};


console.log(arr.myInject(function(a, b){
  return a + b;
}))
