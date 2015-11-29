Array.prototype.bubbleSort = function () {
  for (var i = 0; i < this.length; i++) {
    for (var j = i + 1; j < this.length; j++) {
      if (this[i] > this[j]) {
        var temp = this[i];
        this[i] = this[j];
        this[j] = temp;
      }
    }
  }
  return this
};


var arr = [5,4,67,2,3,7,1,8]
//
// console.log(arr.bubbleSort());

String.prototype.subStrings = function () {
  var subs = [];
  for (var i = 0; i < this.length; i++) {
    for (var j = i + 1; j < this.length; j++) {
      subs.push(this.slice(i, (j + 1)));
    }
  }
  return subs;
};
