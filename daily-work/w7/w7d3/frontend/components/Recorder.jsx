var React = require('react'),
    Jukebox = require('./Jukebox'),
    Track = require('../util/Track'),
    KeyStore = require('../stores/KeyStore'),
    TrackStore = require('../stores/TrackStore'),
    AppDispatcher = require('../dispatcher/Dispatcher');


var Recorder = React.createClass({
  getInitialState: function () {
    return {isRecording: false,
            track: new Track({name: "awesome track"})};
  },

  componentDidMount: function () {
    this.listenerToken = KeyStore.addListener(function () {
      if (this.state.isRecording) {
        var currentTrack = this.state.track;
        currentTrack.addNotes(KeyStore.all());
        this.setState({track: currentTrack});
      }
    }.bind(this));
  },

  componentWillUnmount: function () {
    KeyStore.remove(this.listenerToken);
  },

  startRecording: function () {
    var trackName = $('#track-name').val();
    console.log("recording");
    var currentTrack = new Track({name: trackName});
    currentTrack.startRecording();
    this.setState({
      track: currentTrack,
      isRecording: true
    });
  },

  stopRecording: function () {
    var currentTrack = this.state.track;
    currentTrack.stopRecording();
    this.setState({
      track: currentTrack,
      isRecording: false
    });
    console.log(this.state.track);
  },

  playRecording: function () {
    this.state.track.playRecording();
  },

  saveRecording: function () {
    AppDispatcher.dispatch({
      actionType: "ADD_TRACK",
      track: this.state.track
    });
  },

  render: function () {


    return (
      <div>
        <button onClick={this.startRecording}>Start</button>
        <button onClick={this.stopRecording}>Stop</button>
        <button onClick={this.playRecording}>Play</button>
        <br/>
        <input type='text'
               id='track-name'
               placeholder='Track Name'></input>
        <button onClick={this.saveRecording}>Save</button>
        <br/>
        <Jukebox/>
      </div>
    );
  }
});


module.exports = Recorder;
