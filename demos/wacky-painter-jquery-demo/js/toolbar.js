function Toolbar(painter) {
  this.painter = painter;
  this.$el = $("<div>").addClass('toolbar');
  this.setupToolbar();
  this.registerEvents();
  this.wacky = true;
}

$.extend(Toolbar.prototype, {
  setupToolbar: function () {
    var $addRow = $("<button>").text("Add row").addClass("add-row");
    // var $addRow = $("<button class=add-row>Add row</button>")
    this.$el.append($addRow);

    var $undoButton = $("<button>").text("Undo").addClass("undo-button");
    this.$el.append($undoButton);

    var $colorPicker = $("<input>").attr("type", "color").addClass('color-picker').val('#ff0000');
    this.$el.append($colorPicker);

    var $wacky = $("<button>").text("Simmer down").addClass("wacky");
    this.$el.append($wacky);
  },
  registerEvents: function () {
    this.$el.find('.undo-button').on('click', this.painter.undoStroke.bind(this.painter));
    this.$el.find('.add-row').on('click', this.painter.addRow.bind(this.painter));
    this.$el.find('.wacky').on('click', this.toggleWacky.bind(this));
    this.$el.find('.color-picker').on('change', this.painter.updateColor.bind(this.painter));
  },

  toggleWacky: function () {
    this.wacky = !this.wacky;
    if (this.wacky) {
      this.$el.find('.wacky').text("Simmer down");
    } else {
      this.$el.find('.wacky').text("Make it wacky");
    }
  }
});

module.exports = Toolbar;
