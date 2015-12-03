var Toolbar = require('./toolbar');

var colors = ['darksalmon', 'cornflowerblue', 'red', 'yellow', 'wheat',
  'hotpink'];

function Painter($easel) {
  this.$easel = $easel;
  this.toolbar = new Toolbar(this);
  this.numSquares = 0;
  this.setupEasel();
  this.registerEvents();
  this.painting = false;
  this.brushColor = 'red';
  this.brushStrokes = [];
}

$.extend(Painter.prototype, {
  setupEasel: function () {
    this.$easel.append(this.toolbar.$el);
    _.times(20, this.addRow.bind(this));
  },
  addRow: function () {
    _.times(20, function () {
      var $square = $("<div>").addClass('square').data('id', this.numSquares);
      this.numSquares += 1;
      this.$easel.append($square);
    }.bind(this));
  },
  registerEvents: function () {
   this.$easel.on('mousedown', '.square', this.startPainting.bind(this)); 
   this.$easel.on('mouseenter', '.square',this.paintSquare.bind(this));
   this.$easel.on('mouseup', '.square', this.stopPainting.bind(this));
  },
  startPainting: function (e) {
    this.painting = true;
    this.brushStrokes.push([]);
    this.paintSquare(e);
  },
  stopPainting: function (e) {
    this.painting = false;
  },
  paintSquare: function (e) {
    if (!this.painting) { return }
    var $square = $(e.currentTarget);
    if (this.toolbar.wacky) {
      var color = _.sample(colors);
    } else {
      var color = this.brushColor;
    }
    $square.css('background', color);
    this.brushStrokes[this.brushStrokes.length - 1].push($square.data('id'));
  },
  updateColor: function (e) {
    var color = $(e.target).val();
    this.brushColor = color;
  },
  undoStroke: function (e) {
    if (!this.brushStrokes[0]) { return}

    this.brushStrokes.pop().forEach(function (id) {
      this.$easel.find('.square').eq(id).css('background', '');
    }.bind(this));
  }
});

module.exports = Painter;
