var React = require('react');
var Clock = require('./clock.jsx');
var Weather = require('./weather.jsx');

var WeatherClock = React.createClass({
  render: function() {
    return (
      <div>
        <Clock/>
        <Weather/>
      </div>
    );
  }
});

module.exports = WeatherClock;
