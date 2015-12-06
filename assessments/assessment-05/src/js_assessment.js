// Make a namespace "JSA"
if (window.JSA === undefined) {
  JSA = {};
}

// Write a function, `JSA.realWordsInString(string, dictionary)`, that returns
// an array containing the substrings of `string` that appear in `dictionary`,
// sorted alphabetically.

  JSA.realWordsInString = function(string, dictionary){

    var subs = [];
    for (var i = 0; i < string.length; i++) {
      for (var j = i + 1; j <= string.length; j++) {
        subs.push(string.slice(i,j));
      }
    }

    var matches = []
    for (var i = 0; i < subs.length; i++) {
      for (var j = 0; j < dictionary.length; j++) {
        if (subs[i] === dictionary[j]) {
          var inMatches = false;
          for (var k = 0; k < matches.length; k++) {
            if (matches[k] === subs[i]) {
              inMatches = true;
            }
          }
          if (!inMatches) {
            matches.push(subs[i]);
          }
        }
      }
    }
    return matches.sort();
  };

// Write an Array function, myEach(callback), that passes each element to
// `callback` before returning the original array. Do NOT call the built-in
// Array#forEach method in your implementation.
Array.prototype.myEach = function (fn) {
  for (var i = 0; i < this.length; i++) {
    fn(this[i]);
  }
  return this;
};

// Write a an Array method, myMap, that takes a callback and returns a new array
// containing the result of the callback for each element in the array. Use the
// Array#myEach method you defined above. Do NOT call the built-in Array#forEach
// or Array#map methods in your implementation.
Array.prototype.myMap = function (fn) {
  var newArr = [];
  this.myEach(function (el) {
    newArr.push(fn(el));
  })
  return newArr;
};

// Write a function `JSA.pairMatch(array, callback)`. It should return all pairs
// of indices ([i, j]) for which `callback(array[i], array[j])` returns true.

// NB: Keep in mind that the order of the arguments to the callback may matter.
// e.g., callback = function(a, b) { return a < b }

JSA.pairMatch = function (array, callback) {
  var matches = [];
  for (var i = 0; i < array.length; i++) {
    for (var j = 0; j < array.length; j++) {
      if ( callback(array[i],array[j]) && i !== j ) {
        matches.push([i,j]);
      }
    }
  }
      // debugger

  return matches;
}

// Write an Array method, bubbleSort(callback), that bubble sorts an array.
// It should take an optional callback that compares two elements, returning
// -1 if the first element should appear before the second, 0 if they are
// equal, and 1 if the first element should appear after the second. Do NOT call
// the built-in Array#sort method in your implementation.
//
// Here's a quick summary of the bubble sort algorithm:
//
// Iterate over the elements of the array. If the current element is unsorted
// with respect to the next element, swap them. If any swaps are made before
// reaching the end of the array, repeat the process. Otherwise, return the
// sorted array.

Array.prototype.bubbleSort = function (callback) {
  var copy = [];
  for (var i = 0; i < this.length; i++) {
    copy.push(this[i]);
  }

  var fn;
  if (callback === undefined) {
    fn = function(x, y){
      if (x < y) {
        return -1;
      } else if (x === y) {
        return 0;
      } else {
        return 1;
      }
    }
  } else {
    fn = callback;
  }

  for (var i = 0; i < copy.length; i++) {
    for (var j = 0; j < copy.length - 1; j++) {
      var rank = fn(copy[j], copy[j + 1]);
      if (rank === 1) {
        var temp = copy[j]
        copy[j] = copy[j + 1];
        copy[j + 1] = temp;
      }
    }
  }

  return copy;
};


// write a method, JSA.myCall, that accepts a function, an object, and any
// number of additional arguments. It should call the function with the
// passed-in object as `this`, also passing the remaining arguments. Do NOT use
// the built-in Function#call method in your implementation.
JSA.myCall = function (fn, object, args) {
  var callArgs = []
  for (var i = 2; i < arguments.length; i++) {
    callArgs.push(arguments[i])
  }

  if (callArgs.length !== 0) {
    return fn.apply(object, callArgs);
  } else {
    return fn.bind(object)();
  }
}

// write a Function method, inherits(ParentClass). It should extend the methods
// of `ParentClass.prototype` to the constructor function it is called on.
Function.prototype.inherits = function (ParentClass) {
  var Surrogate = function () {};

  Surrogate.prototype = ParentClass.prototype;
  this.prototype = new Surrogate();
  this.prototype.constructor = this;
  // body...
};

// write a method, `JSA.myCurry(function, object, numArgs)`, that curries the
// function. Remember that a curried function is invoked with one argument at a
// time. For example, the curried form of `sum(1, 2, 3)` would be written as
// `curriedSum(1)(2)(3)`. After `numArgs` have been passed in, invoke the
// original `function` with the accumulated arguments, using `object` as the
// context.

JSA.myCurry = function (fn, object, numArgs){
  // debugger
  if (numArgs < 1) {
    return fn.bind(object)();
  } else {
    return myCurry(fn, fn.bind(object), numArgs - 1);
  }



 }
