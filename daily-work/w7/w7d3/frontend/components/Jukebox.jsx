var React = require('react'),
    TrackStore = require('../stores/TrackStore');

var Jukebox = React.createClass({
  getInitialState: function () {
    return {selected: -1};
  },

  selectTrack: function (e) {
    this.setState({selected: e.target.key});
  },

  render: function () {

    var tracks = TrackStore.all().map(function (track, index) {
      var text;
      if (this.state.selected === index) {
        text = <strong>{track.name}</strong>;
      } else {
        text = track.name;
      }
      return <li key={index} onClick={this.selectTrack}>{text}</li>;
    }.bind(this));

    return (
      <ul>
        {tracks}
      </ul>
    );
  }
});

module.exports = Jukebox;
