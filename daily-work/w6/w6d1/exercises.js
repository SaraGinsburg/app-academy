var sumFn = function() {
  var args = Array.prototype.slice.call(arguments);

  var result = 0;

  for (var i = 0; i < args.length; i++) {
    result += args[i];
  }

  return result;
};

// console.log(sumFn(1,2,3,4,5,6));


Function.prototype.myBind = function (obj) {
  var fn = this;
  var args = Array.prototype.slice.apply(arguments).slice(1);

  return function () {
    return fn.apply(obj, args);
  };
};

// var fn = markov.says.myBind(breakfast, "arg1", "arg2");
// fn( "arg3", "arg4");

//
// console.log(function(a,b,c){
//   return this + a + b + c;
// }.myBind(5,1,2,3)());

var curriedSum = function(numArgs){
  var numbers = [];
  var sum = 0;

  var _curriedSum = function (num) {
    numbers.push(num);
    if (numbers.length === numArgs) {
      for (var i = 0; i < numbers.length; i++) {
        sum += numbers[i];
      }
      return sum;
    } else {
      return _curriedSum;
    }
  };
  return _curriedSum;
};


// console.log(curriedSum(3)(1)(2)(3));


Function.prototype.curry = function (numArgs) {
  var args = [];
  var fn = this;

  var _curry = function (arg) {
    args.push(arg);

    if ( numArgs === args.length ) {
      return fn.apply(null, args);
    } else {
      return _curry;
    }
  };

  return _curry;
};


// console.log(sumFn.curry(4)(1)(2)(3)(4));
