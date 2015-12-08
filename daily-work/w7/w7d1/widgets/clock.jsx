var React = require('react');

var Clock = React.createClass({
  getInitialState: function() {
    return {currentTime: new Date()};
  },

  tick: function() {
    this.setState({currentTime: new Date()});
  },

  componentDidMount: function() {
    this.intervalId = setInterval(this.tick, 1000);
  },

  componentWillUnmount: function() {
    clearInterval(this.intervalId);
  },

  render: function() {
    return (
      <span>{this.state.currentTime.toString()}</span>
    );
  }
});

module.exports = Clock;
