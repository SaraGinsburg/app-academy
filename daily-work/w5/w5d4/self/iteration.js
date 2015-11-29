Array.prototype.bubbleSort = function () {
  var swaps = true;
  while (swaps) {
    swaps = false;
    for (var i = 0; i < this.length - 1; i++) {
      if (this[i] > this[i+1]) {
        var temp = this[i];
        this[i] = this[i+1];
        this[i+1] = temp;
        swaps = true;
      }
    }
  }
  return this;
};

// arr = [6,3,5,4,8,9,1,2,7];
// console.log(arr.bubbleSort());
String.prototype.subStrings = function () {
  var subs = [''];
  for (var i = 0; i < this.length; i++) {
    for (var j = i+1; j <= this.length; j++) {
      subs.push(this.slice(i,j))
    }
  }
  return subs;
};

// console.log("hello".subStrings());
