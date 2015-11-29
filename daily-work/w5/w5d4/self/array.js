Array.prototype.uniq = function () {
  var result = [];
  for (var i = 0; i < this.length; i++) {
    var newElement = true;
    for (var j = 0; j < result.length; j++) {
      if (result[j] === this[i]) {
        newElement = false;
      }
    }
    if (newElement) {
      result.push(this[i]);
    }
  }

  return result;
};

var arr = [1,2,3,3,5,6,3,1];
// console.log(arr.uniq());


Array.prototype.twoSum = function (target) {
  var results = [];
  for (var i = 0; i < this.length; i++) {
    for (var j = i + 1; j < this.length; j++) {
      if (this[i] + this[j] === target) {
        results.push([i,j]);
      }
    }
  }
  return results;
};

// console.log(arr.twoSum(8));


Array.prototype.transpose = function () {
  var result = []
  for (var i = 0; i < this[0].length; i++) {
    result.push([]);
    for (var j = 0; j < this.length; j++) {
      result[i].push(this[j][i]);
    }
  }

  return result;
};

var grid = [
  [1,2,3],
  [4,5,6],
  [7,8,9]
]

// console.log(grid.transpose());
