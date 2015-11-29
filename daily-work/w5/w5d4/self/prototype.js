function Cat(name, owner) {
  this.name = name;
  this.owner = owner;
}

Cat.prototype.cuteStatement = function () {
  return this.owner + " loves " + this.name;
};

var c1 = new Cat("lily", "daniel");
var c2 = new Cat("mew", "daniel");

console.log(c1.cuteStatement());
console.log(c2.cuteStatement());


Cat.prototype.cuteStatement = function () {
  return "Everyone loves " + this.name;
};

console.log(c1.cuteStatement());
console.log(c2.cuteStatement());

Cat.prototype.meow = function () {
  return this.name + ": 'meow'";
};

console.log(c1.meow());
console.log(c2.meow());

c2.meow = function(){
  return this.name + ": 'waddup ballers!'"
};

console.log(c1.meow());
console.log(c2.meow());
