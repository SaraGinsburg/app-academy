var exponentation = function (base, power) {
  if(power === 0) {
    return 1;
  }
  return base * exponentation(base, power - 1);
}

var fibbonacci = function (n) {
  if(n <= 2) {
    return [0, 1].slice(0, n)
  }
  var res = fibbonacci(n-1)
  res.push(res[res.length - 1] + res[res.length - 2])
  return res
}

//
// console.log(fibbonacci(0));
// console.log(fibbonacci(1));
// console.log(fibbonacci(2));
// console.log(fibbonacci(3));
// console.log(fibbonacci(10));


Array.prototype.bSearch = function (target) {
  if (this === []) {
    return null
  }

  var mid = this.length/2

  if (this[mid] === target) {
    return mid
  } else if (this[mid] < target) {
    //return right half
    return this.slice(mid+1, this.length).bSearch(target);
  } else {
    //resturn left half
    return this.slice(0, mid).bSearch(target);
  }
};

// console.log([ 0, 1, 1, 2, 3, 5, 8, 13, 21, 34 ].bSearch(4));

var makeChange = function(target, coins) {
  if (target === 0) {
    return [];
  } else {

    var allAboveTarget = true

    for (var i = 0; i < coins.length; i++) {
      // console.log("coin: " + coins[i] +" target: " + target);
      if (coins[i] < target) {
        allAboveTarget = false
      }
    }

    if (allAboveTarget){
      // console.log("hi");
      return null;
    }

  }

  var bestChange = null;

  for (var i = 0; i < coins.length; i++) {

    if(coins[i] <= target){

      var remainder = target - coins[i];

      var bestRemainder = makeChange(remainder, coins.slice(i + 1, coins.length));

      if (bestRemainder !== null){

        var thisChange = [coins[i]].concat(bestRemainder);

        if (bestChange === null || thisChange.length < bestChange.length){
          bestChange = thisChange;
        }
      }

    }
  }
  if(bestChange === null){
    bestChange = []
  }
  return bestChange;
}

console.log(makeChange(14, [10, 7, 1]));
console.log(makeChange(24, [10, 7, 1]));
