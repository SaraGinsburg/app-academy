describe('realWordsInString', function () {
  it("can find a simple word", function () {
    words = JSA.realWordsInString("asdfcatqwer", ['cat', 'car']);
    expect(words).toEqual(['cat']);
  });

  it("doesn't find spurious words", function () {
    words = JSA.realWordsInString("batcabtarbrat", ['cat', 'car']);
    expect(words).toEqual([]);
  });

  it("can find words within words", function () {
    //note that the method should NOT return duplicate words
    dictionary = ["bears", "ear", "a", "army"]
    words = JSA.realWordsInString("erbearsweatmyajs", dictionary);
    expect(words).toEqual(['a', 'bears', 'ear']);
  });
});

describe("Array#myEach", function () {
  var originalArray = null;
  var spy = {
    callback: function (el) { return el; }
  };

  // it does not call forEach (setup)
  beforeEach(function () {
    spyOn(Array.prototype, 'forEach').and.callThrough();
  });

  // it does not call forEach (verification)
  afterEach(function () {
    expect(Array.prototype.forEach).not.toHaveBeenCalled();
  });

  it("calls the callback passed to it", function () {
    spyOn(spy, "callback");
    [1, 2, 3].myEach(spy.callback);
    expect(spy.callback).toHaveBeenCalled();
  });

  it("yields each element to the callback", function () {
    spyOn(spy, "callback");
    [1, 2].myEach(spy.callback);
    expect(spy.callback).toHaveBeenCalledWith(1);
    expect(spy.callback).toHaveBeenCalledWith(2);
  });

  it("is chainable and returns the original array", function () {
    originalArray = ["original array"];
    expect(originalArray.myEach(spy.callback)).toBe(originalArray);
  });
});

describe("Array#myMap", function() {
  var originalArray, spy;

  beforeEach(function () {
    originalArray = null;
    spy = {
      callback: function (el) {
        return el * el;
      }
    };
  });

  // it does not call forEach or map (setup)
  beforeEach(function () {
    spyOn(Array.prototype, 'forEach').and.callThrough();
    spyOn(Array.prototype, 'map').and.callThrough();
  });

  // it does not call forEach or map (verification)
  afterEach(function () {
    expect(Array.prototype.forEach).not.toHaveBeenCalled();
    expect(Array.prototype.map).not.toHaveBeenCalled();
  });

  it("calls the callback passed to it", function () {
    spyOn(spy, "callback");
    [1, 2, 3].myMap(spy.callback);
    expect(spy.callback).toHaveBeenCalled();
  });

  it("yields each element to the callback", function () {
    spyOn(spy, "callback");
    [1, 2].myMap(spy.callback);
    expect(spy.callback).toHaveBeenCalledWith(1);
    expect(spy.callback).toHaveBeenCalledWith(2);
  });

  it("calls the Array#myEach method", function () {
    originalArray = [1, 2, 3];
    spyOn(originalArray, "myEach");
    originalArray.myMap(spy.callback);
    expect(originalArray.myEach).toHaveBeenCalled();
  });

  it("returns a mapped array", function () {
    originalArray = [1, 2, 3];
    expect(originalArray.myMap(spy.callback)).toEqual([1, 4, 9]);
  });

  it("does not modify the original array", function () {
    originalArray = [1, 2, 3];
    originalArray.myMap(spy.callback);
    expect(originalArray).toEqual([1, 2, 3]);
  });
});

describe("pairMatch", function() {
  var array;

  var sumToZero = function (x, y) { return x + y === 0; };

  var sumToEven = function (x, y) { return (x + y) % 2 === 0; };

  var isGreater = function (x, y) { return x > y; };

  it("returns [] when no match is found", function () {
    array = [1, 2, 3];
    expect(JSA.pairMatch(array, sumToZero)).toEqual([]);
  });

  it("doesn't return pairs containing the same element", function () {
    array = [0, 1, 2];
    expect(JSA.pairMatch(array, sumToZero)).toEqual([]);
  });

  it("returns positions of pairs that sum to zero", function () {
    array = [1, 0, -1];
    expect(JSA.pairMatch(array, sumToZero)).toEqual([
      [0, 2], [2, 0]
    ]);
  });

  it("returns positions of pairs that sum to an even number", function () {
    array = [1, 1, 3, 2];
    expect(JSA.pairMatch(array, sumToEven)).toEqual([
      [0, 1], [0, 2], [1, 0], [1, 2], [2, 0], [2, 1]
    ]);
  });

  it("returns positions of pairs where x > y", function () {
    array = [3, 2, 1];
    expect(JSA.pairMatch(array, isGreater)).toEqual([
      [0, 1], [0, 2], [1, 2]
    ]);
  });
});

describe("#bubbleSort", function () {
  var array = [3, 1, 2, 5, 4];
  var sortedArray = array.slice().sort();
  var reversedArray = sortedArray.slice().reverse();

  // it does not call sort (setup)
  beforeEach(function () {
    spyOn(Array.prototype, 'sort').and.callThrough();
  });

  // it does not call sort (verification)
  afterEach(function () {
    expect(Array.prototype.sort).not.toHaveBeenCalled();
  });

  it("works with an empty array", function () {
    expect([].bubbleSort()).toEqual([]);
  });

  it("works with an array of one item", function () {
    expect([1].bubbleSort()).toEqual([1]);
  });

  it("sorts numbers", function () {
    expect(array.bubbleSort()).toEqual(sortedArray);
  });

  it("will use block if given", function () {
    sorted = array.bubbleSort(function (num1, num2) {
      // order numbers based on descending sort of their squares
      var square1 = Math.pow(num1, 2);
      var square2 = Math.pow(num2, 2);
      if (square2 < square1) {
        return -1;
      } else if (square2 === square1) {
        return 0;
      } else {
        return 1;
      }
    });

    expect(sorted).toEqual(reversedArray);
  });

  it("does not modify original", function () {
    dupedArray = array.slice();
    dupedArray.bubbleSort();
    expect(dupedArray).toEqual(array);
  });
});

describe("myCall", function () {
  it("calls the function, binding the given context", function () {
    var myObj = { name: "John" };

    var myFunc = function () { return this.name; };

    expect(JSA.myCall(myFunc, myObj)).toMatch(/John/);
  });

  it("should pass through any given arguments", function () {
    var myObj = { count: 10 }

    var adder = function (x, y, z) {
      this.count += (x + y + z);
      return this.count;
    };

    expect(JSA.myCall(adder, myObj, 1, 2, 3)).toEqual(16);
  });
});

describe("Function.prototype.inherits", function() {
  var Animal, Dog, dog;

  beforeEach(function() {
    Animal = function() { this.name = "Yogi"; };

    Animal.prototype.makeNoise = function() { return "Hi!"; };

    Dog = function() { this.age = 7; };

    Dog.inherits(Animal);

    Dog.prototype.bark = function() { return "Woof!"; };

    dog = new Dog();
  });

  it("should properly set up the prototype chain between a child and parent", function() {
    expect(dog.bark()).toBe("Woof!");
    expect(dog.makeNoise()).toBe("Hi!");
  });

  it("should not call the parent's constructor function", function() {
    expect(dog.name).toBeUndefined();
  });

  it("should maintain separation of parent and child prototypes", function() {
    Dog.prototype.someProperty = 42;
    var animal = new Animal();
    expect(animal.someProperty).toBeUndefined();
    expect(animal.makeNoise()).toBe("Hi!");
  });

  it("should properly work for longer inheritance chains", function() {
    var Poodle = function() { this.name = "Bill"; };

    Poodle.inherits(Dog);

    Poodle.prototype.shave = function() { return "Brrr."; };

    var poodle = new Poodle();
    expect(poodle.name).toBe("Bill");
    expect(poodle.shave()).toBe("Brrr.");
    expect(poodle.makeNoise()).toBe("Hi!");
    expect(poodle.bark()).toBe("Woof!");
  });
});

describe("myCurry", function () {
  beforeEach(function () {
    this.myObj = {
      count: 10
    };
  });

  it("should take a function, object, and curry if 1 is passed", function () {
    var echo = function (arg) {
      return arg;
    };

    var first = JSA.myCurry(echo, this.myObj, 1);
    expect(first("one")).toMatch(/one/);
  });

  it("binds to obj if passed in", function () {
    var count = function () {
      return this.count;
    };

    var first = JSA.myCurry(count, this.myObj, 1);
    expect(first("")).toEqual(10);
  });

  it("currys arguments and calls function after called with total num args", function () {
    var sum = function(a, b, c) {
      return this.count + a + b + c;
    };
    var curriedSum = JSA.myCurry(sum, this.myObj, 3);
    var result = curriedSum(1)(2)(3);
    expect(result).toEqual(16);
  });
});

