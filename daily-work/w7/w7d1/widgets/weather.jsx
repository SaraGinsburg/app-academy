var React = require('react');

var Weather = React.createClass({
  getInitialState: function() {
    return {weather: {
      name: "",
      main: {
        temp_max: "",
        temp_min: "",
      },
      weather: [
        {
          description: ""
        }
      ],
      wind: {
        deg: ""
      }
    }};
  },

  getWeather: function(latitude, longitude) {
    var xmlhttp = new XMLHttpRequest();

    xmlhttp.onreadystatechange = function() {
      if (xmlhttp.readyState == XMLHttpRequest.DONE) {
        if (xmlhttp.status == 200) {
          // console.log(JSON.parse(xmlhttp.responseText));
          this.setState({weather: JSON.parse(xmlhttp.responseText)});
        } else {
          console.log(xmlhttp);
        }
      }
    }.bind(this);
    var urlString = "http://api.openweathermap.org/data/2.5/weather?lat=";
    urlString += latitude.toString();
    urlString += "&lon=";
    urlString += longitude.toString();
    urlString += "&APPID=645c5d39c7603f17e23fcaffcea1a3c1";

    xmlhttp.open("GET", urlString, true);
    xmlhttp.send();
  },

  componentDidMount: function() {
    var geoLocation = navigator.geolocation.getCurrentPosition(function(pos){
      var coords = pos.coords;
      var latitude = coords.latitude;
      var longitude = coords.longitude;
      this.getWeather(latitude, longitude);
    }.bind(this));
  },

  render: function() {
    console.log(this.state.weather);
    var currentWeather = this.state.weather;
    // var cityName = currentWeather.name;
    // debugger;
    // var max_temp = currentWeather.main.temp_max;
    return (
      <div>
        <span>City: {currentWeather.name}</span><br/>
        <span>High Temp: {currentWeather.main.temp_max}K</span><br/>
        <span>Low Temp: {currentWeather.main.temp_min}K</span><br/>
        <span>Description: {currentWeather.weather[0].description}</span><br/>
        <span>Wind Direction: {currentWeather.wind.deg}</span>
      </div>
    );
  }

});

module.exports = Weather;
