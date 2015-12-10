var KeyStore = require('../stores/KeyStore'),
    KeyActions = require('../actions/KeyActions');

var Track = function (attributes) {
  this.name = attributes.name;
  this.roll = attributes.roll || [];
  // this.startRecording();
};

Track.prototype.startRecording = function () {
  this.roll = [];
  this.startTime = new Date();
};

Track.prototype.addNotes = function (notes) {
  this.roll.push({
    timeSlice: (new Date() - this.startTime),
    notes: notes //KeyStore.all() usually
  });
};

Track.prototype.stopRecording = function () {
  this.addNotes([]);
};

Track.prototype.playRecording = function () {
  if ( this.interval ){
    return;
  }

  var playbackStartTime = new Date(),
      rollPosition = 0;

  var callback = function () {
    if (rollPosition < this.roll.length) {
      var currentSegment = this.roll[rollPosition];

      if (Date.now() - playbackStartTime < currentSegment.timeSlice) {
        return;
      }

      KeyActions.keysPlayed(currentSegment.notes);
      rollPosition ++;
      clearInterval(this.interval);

      var newInterval = (
        this.roll[rollPosition].timeSlice -
          this.roll[rollPosition -1].timeSlice);

      this.interval = setTimeout(callback, newInterval);
    } else {
      this.interval = null;
    }
  }.bind(this);

  this.interval = setTimeout(callback, this.roll[rollPosition].timeSlice);
};

module.exports = Track;
