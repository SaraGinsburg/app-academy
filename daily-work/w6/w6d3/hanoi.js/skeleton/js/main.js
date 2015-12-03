var HanoiView = require('./view.js');//...require appropriate file
var HanoiGame = require('../../hanoi-core-solution/src/game');//...require appropriate file(look in /hanoi-core-solution)

$(function () {
  var $el = $('.hanoi');
  var game = new HanoiGame();
  var view = new HanoiView(game, $el);
});
