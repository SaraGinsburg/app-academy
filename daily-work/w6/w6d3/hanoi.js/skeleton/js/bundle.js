/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};

/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {

/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;

/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};

/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);

/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;

/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}


/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;

/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;

/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "/js/";

/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ function(module, exports, __webpack_require__) {

	var HanoiView = __webpack_require__(1);//...require appropriate file
	var HanoiGame = __webpack_require__(2);//...require appropriate file(look in /hanoi-core-solution)

	$(function () {
	  var $el = $('.hanoi');
	  var game = new HanoiGame();
	  var view = new HanoiView(game, $el);
	});


/***/ },
/* 1 */
/***/ function(module, exports) {

	function View (game, $el) {
	  this.game = game;
	  this.$el = $el;
	  this.setUpTowers();
	  this.setUpHandlers();
	  this.clicked = false;
	  this.$fromStack;
	};

	View.prototype.setUpTowers = function () {
	  var $stack;

	  for (var i = 0; i < 3; i++) {
	    $stack = $("<ul>").data('idx', i);
	    for (var j = 0; j < 3; j++) {
	      $stack.append($("<li>"));
	    }
	    this.$el.append($stack);
	  }
	  this.render();
	};

	View.prototype.setUpHandlers = function () {
	  this.$el.on('click', 'ul', this.handleClick.bind(this));
	};

	View.prototype.handleClick = function (e) {
	  var $currentStack = $(e.currentTarget);
	  if (this.clicked) {
	    this.game.move(
	      $fromStack.data('idx'),
	      $currentStack.data('idx')
	    );

	    if (this.game.isWon()) {
	      console.log("winner");
	      $('ul').addClass('game-over');
	      $('li').addClass('game-over');
	    }
	  } else {
	    $fromStack = $currentStack;
	  }
	  this.clicked = !this.clicked;
	  console.log(this.game.towers);
	  this.render();
	};


	View.prototype.render = function () {
	  var gameTowers = this.game.towers;
	  var $towers = this.$el.find("ul");

	  for (var i = 0; i < 3; i++) {
	    for (var j = 0; j < 3; j++) {
	      var $tower = $towers.eq(i).find("li");
	      var diskNum = gameTowers[i][j];

	      $tower.eq(2 - j).removeClass();

	      if (diskNum !== undefined) {
	        $tower.eq(2 - j).addClass("disk-" + diskNum);
	      }
	    }
	  }
	};


	module.exports = View;


/***/ },
/* 2 */
/***/ function(module, exports) {

	function Game () {
	  this.towers = [[3, 2, 1], [], []];
	};

	Game.prototype.isValidMove = function (startTowerIdx, endTowerIdx) {
	  var startTower = this.towers[startTowerIdx];
	  var endTower = this.towers[endTowerIdx];

	  if (startTower.length === 0) {
	    return false;
	  } else if (endTower.length == 0) {
	    return true;
	  } else {
	    var topStartDisc = startTower[startTower.length - 1];
	    var topEndDisc = endTower[endTower.length - 1];
	    return topStartDisc < topEndDisc;
	  }
	};

	Game.prototype.isWon = function () {
	  // move all the discs to the last or second tower
	  return (this.towers[2].length == 3) || (this.towers[1].length == 3);
	};

	Game.prototype.move = function (startTowerIdx, endTowerIdx) {
	  if (this.isValidMove(startTowerIdx, endTowerIdx)) {
	    this.towers[endTowerIdx].push(this.towers[startTowerIdx].pop());
	    return true;
	  } else {
	    return false;
	  }
	};

	Game.prototype.print = function () {
	  console.log(JSON.stringify(this.towers));
	};

	Game.prototype.promptMove = function (reader, callback) {
	  this.print();
	  reader.question("Enter a starting tower: ", function (start) {
	    var startTowerIdx = parseInt(start);
	    reader.question("Enter an ending tower: ", function (end) {
	      var endTowerIdx = parseInt(end);
	      callback(startTowerIdx, endTowerIdx)
	    });
	  });
	};

	Game.prototype.run = function (reader, gameCompletionCallback) {
	  this.promptMove(reader, (function (startTowerIdx, endTowerIdx) {
	    if (!this.move(startTowerIdx, endTowerIdx)) {
	      console.log("Invalid move!");
	    }

	    if (!this.isWon()) {
	      // Continue to play!
	      this.run(reader, gameCompletionCallback);
	    } else {
	      this.print();
	      console.log("You win!");
	      gameCompletionCallback();
	    }
	  }).bind(this));
	};

	module.exports = Game;


/***/ }
/******/ ]);