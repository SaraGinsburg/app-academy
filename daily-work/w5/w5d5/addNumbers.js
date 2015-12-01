var readline = require('readline');
var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

var addNumbers = function(sum, numsLeft, callback) {
  reader.question("Enter number to add to sum", function(numString1){
    var num1 = parseInt(numString1);
      console.log(num1);
      sum += num1;
      numsLeft -= 1;
    if (numsLeft > 0){
      addNumbers(sum, numsLeft, callback);
    } else {
      callback(sum);
    }
  });
};



addNumbers(0, 10, function (sum) {
  console.log("Total Sum: " + sum);
});
