Array.prototype.myEach = function (fn) {
  for (var i = 0; i < this.length; i++) {
    fn(this[i]);
  }

  return this;
};

// var arr = [1,2,3,4];
// arr.myEach( function(item){
//   console.log(item);
// });

Array.prototype.myMap = function (fn) {
  var mapped = [];
  this.myEach(function(item){
    mapped.push(fn(item));
  })

  return mapped;
};

// console.log(arr.myMap( function(item){
//   return item*item;
// }));


Array.prototype.myInject = function (fn) {
  var accumulator = this[0];

  var remainingArr = this.slice(1);

  remainingArr.myEach(function(item){
    accumulator = fn(accumulator, item);
  });

  return accumulator;
};

console.log(arr.myInject(function(a, b){
  return a + b;
}));
