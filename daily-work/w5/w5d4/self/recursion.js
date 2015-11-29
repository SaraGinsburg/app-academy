var exp = function (base, power) {
  if (power < 1) {
    return 1;
  } else if (power === 1) {
    return base;
  } else {
    var half = Math.floor(power / 2);
    return exp(base, half) * exp(base, power - half);
  }
};

// console.log(exp(2,4));
// console.log(exp(2,3));
// console.log(exp(2,2));
// console.log(exp(2,1));
// console.log(exp(2,0));

var fib = function (num) {
  if (num < 2) {
    return [0];
  } else if (num === 2) {
    return [0,1]
  } else {
    var prevNums = fib(num - 1);
    prevNums.push(prevNums[num - 2] + prevNums[num - 3]);
    return prevNums
  }
};

// console.log(fib(1));
// console.log(fib(2));
// console.log(fib(3));
// console.log(fib(4));
// console.log(fib(10));

Array.prototype.bSearch = function (target) {
  if (this === []) {
      return null
  } else if (this.length === 1) {
      return this[0] === target ? 0 : null;
  } else {
    var mid = Math.floor(this.length / 2);

    if (this[mid] === target) {
        return mid;
    } else if (this[mid] > target) {
        return this.slice(0,mid).bSearch(target);
    } else {
        var right = this.slice(mid).bSearch(target);
        return right !== null ? mid + right : null
    }
  }
};

// var arr = [1,2,5,7,9,10,15,17,18,24,27,28];
// console.log(arr.bSearch(10));
// console.log(arr.bSearch(24));
// console.log(arr.bSearch(28));
// console.log(arr.bSearch(30));
// console.log(arr.bSearch(-10));
// console.log(arr.bSearch(20));


//FROM SOLUTIONS
var makeChange = function (target, coins) {
  if (target === 0) {
    return [];
  }

  var bestChange = null;

  function reverseSorter(a, b) {
    if (a < b) {
      return 1;
    } else if (a > b) {
      return -1;
    } else {
      return 0;
    }
  }

  coins.sort(reverseSorter).forEach(function(coin, index) {
    if (coin > target) {
      return;
    }

    var remainder = target - coin;
    // remember the optimization where we don't try to use high coins
    // if we're already using a low one?
    var restChange = makeChange(remainder, coins.slice(index));

    var change = [coin].concat(restChange);
    if (!bestChange || (change.length < bestChange.length)) {
      bestChange = change;
    }
  });

  return bestChange;
}

Array.prototype.mergeSort = function () {
  if (this === []) {
    return [];
  } else if (this.length === 1) {
    return this;
  } else {

    var mid = Math.floor(this.length / 2);

    return merge(
      this.slice(0, mid).mergeSort(),
      this.slice(mid).mergeSort()
    );
  }
};

var merge = function (arr1, arr2) {
  var result = [];

  while( arr1.length > 0 && arr2.length > 0 ){
    if ( arr1[0] <= arr2[0] ) {
      result.push(arr1.shift());
    } else {
      result.push(arr2.shift());
    }
  }

  result = result.concat(arr1).concat(arr2);
  return result;
}

// arr = [6,3,5,4,8,9,1,2,7];
// console.log(arr.mergeSort());

Array.prototype.subSets = function () {
  if (this.length === 0) {
    return [[]];
  }
  var first = this[0];
  var otherSubs = this.slice(1).subSets();

  var newSubs = otherSubs.map(function (otherSubs) {
    return [first].concat(otherSubs);
  });

  return newSubs.concat(otherSubs)
};

// arr = [1,2,3,4];
// console.log(arr.subSets());
