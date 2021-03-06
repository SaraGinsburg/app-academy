(function () {
  // Make a namespace `Assessment`.
  if(window.Assessment === undefined){
    Assessment = {};
  }


  // write String.prototype.mySlice. It should take a start index and an
  // (optional) end index.
  String.prototype.mySlice = function (start, end) {
    // body...
    if (end === undefined) {
      end = this.length;
    }
    var result = "";
    for (var i = start; i < end; i++) {
      result += this.charAt(i);
    }

    return result;
  };

  // write Array.prototype.myReduce (analogous to Ruby's Array#inject).
  Array.prototype.myReduce = function (fn) {
    var accumulator = this[0];

    this.slice(1).forEach(function (el) {
      accumulator = fn(accumulator, el);
    });

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
    if ( this.length < 2 ) {
      return this;
    }

    if (comparator === undefined) {
      comparator = function (x, y) {
        if (x < y) {
          return -1;
        } else if (x === y) {
          return 0;
        } else {
          return 1;
        }
      }
    }

    var pivot = this[0];

    var left = [];
    var right = [];
    var current;

    for (var i = 1; i < this.length; i++) {
      current = this[i];

      if (comparator(pivot, current) === 1) {
        left.push(current);
      } else  {
        right.push(current);
      }
    }

    return left.quickSort(comparator)
      .concat([pivot])
      .concat(right.quickSort(comparator));

  };

  // write myFind(array, callback). It should return the first element for which
  // callback returns true, or undefined if none is found.
  Assessment.myFind = function (array, callback) {
    //why didnt this work?
    // array.forEach(function (element) {
    //   if (callback(element)) {
    //     return element;
    //   }
    // });

    for (var i = 0; i < array.length; i++) {
      if (callback(array[i])) {
        return array[i];
      }
    }
    return undefined;
  };



  // write sumNPrimes(n)
  var isPrime = function(num){
    for (var i = 2; i < num; i++) {
      if (num % i === 0) {
        return false;
      }
    }
    return true;
  };

  Assessment.sumNPrimes = function (n) {
    if (n === 0) {
      return 0
    }

    var primes = 1
    var sum = 2
    var num = 3

    while(primes < n){
      if (isPrime(num)) {
        sum += num;
        primes ++;
      }
      num += 2;
    }

    return sum;
  };

  Function.prototype.inherits = function (sup) {
    var sub = this;
    var sur = function () {};

    sur.prototype = sup.prototype;
    sub.prototype = new sur();
    sub.prototype.constructor = sub;
  };

  // write Function.prototype.myBind.
  // Function.prototype.myBind = function (context) {
  //   //always apply (NOT call!)
  //   var fn = this;
  //
  //   var bindArgs = Array.prototype.slice.apply(arguments).slice(1);
  //
  //   return function () {
  //     var callArgs = Array.prototype.slice.apply(arguments);
  //     return fn.apply(context, bindArgs.concat(callArgs));
  //   }; //no function call
  // };
  Function.prototype.myBind = function (context) {
    var fn = this;
    var bindArgs = [].slice.apply(arguments).slice(1);

    return function () {
      var callArgs = [].slice.apply(arguments);
      return fn.apply(context, bindArgs.concat(callArgs));
    };
  };


  // write Function.prototype.inherits.
  // Function.prototype.inherits = function (SuperClass) {
  //   var Surrogate = function (){};
  //   var SubClass = this;
  //
  //   Surrogate.prototype = SuperClass.prototype;
  //   SubClass.prototype = new Surrogate();
  //   SubClass.prototype.constructor = SubClass;
  // };

})();
