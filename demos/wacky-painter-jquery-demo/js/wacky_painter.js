//entry point
//kicks everything off
var Painter = require('./painter');

$(function () {
  var $easel = $('#easel');
  // $easel.html('Hellloo');
  new Painter($easel);
});
