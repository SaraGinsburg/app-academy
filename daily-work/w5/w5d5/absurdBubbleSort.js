var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var absurdBubbleSort = function (arr, sortCompletionCallback){
  function outerBubbleSortLoop(madeAnySwaps) {
    if (madeAnySwaps) {
      madeAnySwaps = false;
      innerBubbleSortLoop(arr, 0, madeAnySwaps, outerBubbleSortLoop);
    } else {
      sortCompletionCallback(arr);
    }
  }
  outerBubbleSortLoop(true);
};


var askIfGreaterThan = function (el1, el2, callback){
  reader.question("Is " + el1 + " greater than " + el2 + "? (y/n) ",
    function(response){

    if (response === "y") {
      callback(true);
    } else {
      callback(false);
    }
  });
};

var innerBubbleSortLoop = function(arr, i , madeAnySwaps, outerBubbleSortLoop){
  if (i < arr.length - 1) {
    askIfGreaterThan(arr[i],arr[i + 1], function(isGreaterThan){

      if (isGreaterThan) {
        var temp = arr[i];
        arr[i] = arr[i+1];
        arr[i+1] = temp;

        madeAnySwaps = true;
      }
      
      console.log(arr);
      innerBubbleSortLoop(arr, i + 1, madeAnySwaps, outerBubbleSortLoop);
    });
  } else {
    outerBubbleSortLoop(madeAnySwaps);
  }
};


absurdBubbleSort([3, 5, 2, 1], function (arr) {
  console.log("Sorted array: " + JSON.stringify(arr));
  reader.close();
});
