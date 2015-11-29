Array.prototype.uniq = function(){
  var items = {};

  for (var i = 0; i < this.length; i++) {
    items[this[i]] = true;
  }

  var result = [];

  for(var key in items){
    if (items.hasOwnProperty(key)) {
      result.push(key);
    }
  }

  return result;
};
//
// console.log([1,1,1,2,2,2,3,3,3].uniq());
//
// console.log([1,2,3].uniq());
//
// console.log(["hello", "hello", "goodbye"].uniq());
//
// console.log([].uniq());

Array.prototype.twoSum = function(target){
  var results = [];

  for (var i = 0; i < this.length; i++) {
    for (var j = i+1; j < this.length; j++) {
      if(this[j] + this[i] === target) {
        results.push([i,j]);
      }
    }
  }

  return results;
}

var arr = [1,2,3,4,7,9,-1,20];
//
// console.log(arr.twoSum(11));
// console.log(arr.twoSum(8));
// console.log(arr.twoSum(19));
// console.log(arr.twoSum(40));


Array.prototype.transpose = function () {
  var transposed = [];
  for (var i = 0; i < this.length; i++) {
    transposed.push([])
    for (var j = 0; j < this[0].length; j++) {
      transposed[i].push(this[j][i]);
    }
  }
  return transposed;
};

var arr = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8]
  ];

// console.log(arr.transpose());
