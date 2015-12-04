(function () {
  // Make a namespace `Assessment`.
  if (window.Assessment === undefined){
    window.Assessment = {};
  }
  // write String.prototype.mySlice. It should take a start index and an
  // (optional) end index.
  String.prototype.mySlice = function (start, end) {
    var result = "";

    if (start > end) {
      return result;
    }
    var endIdx = end ? end : this.length;
    for (var i = start; i < endIdx; i++) {
      result += this.charAt(i);
    }
    return result;
  };

  // write Array.prototype.myReduce (analogous to Ruby's Array#inject).
  Array.prototype.myReduce = function (fn) {
    var accumulator = this[0]

    for (var i = 1; i < this.length; i++) {
      accumulator = fn(accumulator, this[i]);
    }

    return accumulator;
  };
  // write Array.prototype.quickSort(comparator). Here's a quick refresher if
  // you've forgotten how quickSort works:
  //   - choose a pivot element from the array (usually the first)
  //   - for each remaining element of the array:
  //     - if the element is less than the pivot, put it in the left half of the
  //     array.
  //     - otherwise, put it in the right half of the array.
  //   - recursively call quickSort on the left and right halves, and return the
  //   full sorted array.

  Array.prototype.quickSort = function (comparator) {
    // body...
    if (this.length < 2) {
      return this;
    }

    if (comparator === undefined) {
      comparator = function (x,y) {
        if (x < y) {
          return -1;
        } else if (x === y) {
          return 0;
        } else {
          return 1;
        }
      };
    }

    var pivot = this[0];
    var left = [];
    var right = [];

    for (var i = 1; i < this.length; i++) {
      var comp = comparator(this[i], pivot);
      if (comp === -1) {
        left.push(this[i]);
      } else {
        right.push(this[i]);
      }
    }

    return left.quickSort(comparator)
        .concat([pivot])
        .concat(right.quickSort(comparator));
  };

  // write myFind(array, callback). It should return the first element for which
  // callback returns true, or undefined if none is found.
  Assessment.myFind = function (array, callback) {
    for (var i = 0; i < array.length; i++) {
      if (callback(array[i])) {
        return array[i];
      }
    }
    return undefined;
  };

  // write sumNPrimes(n)
  Assessment.sumNPrimes = function(n){
    var sum = 0;
    var primes = 0;
    var num = 2

    while(primes < n){
      if (isPrime(num)) {
        sum += num;
        primes ++;
      }
      num ++;
    }
    return sum;
  };

  var isPrime = function (num) {
    for (var i = 2; i < num; i++) {
      if (num % i === 0) {
        return false;
      }
    }
    return true;
  };

  // write Function.prototype.myBind.
  Function.prototype.myBind = function (context) {
    var fn = this;

    var bindArgs = [].slice.apply(arguments).slice(1);

    return function () {
      var callArgs = [].slice.apply(arguments);
      return fn.apply(context, bindArgs.concat(callArgs));
    }
  };

  // Function.prototype.myBind = function (context) {
  //   var fn = this;
  //
  //   var newArgs = Array.prototype.slice.apply(arguments).slice(1);
  //
  //   return function () {
  //     var oldArgs = Array.prototype.slice.apply(arguments);
  //     var allArgs = newArgs.concat(oldArgs);
  //     return fn.apply(context, allArgs);
  //   }
  //
  // };

  // write Function.prototype.inherits.
  Function.prototype.inherits = function (SuperClass) {
    var Surrogate = function(){};
    var SubClass = this;

    Surrogate.prototype = SuperClass.prototype;
    SubClass.prototype = new Surrogate();
    SubClass.prototype.constructor = SubClass;
  };

  // Function.prototype.inherits = function (superClass) {
  //   var Surrogate = function(){};
  //   var subClass = this;
  //
  //   Surrogate.prototype = superClass.prototype;
  //   // subClass.prototype = Surrogate();
  //   subClass.prototype = new Surrogate();
  //   // subClass.constructor = this.constructor;
  //   subClass.prototype.constructor = subClass;
  //
  // };
})();
