var React = require('react'),
    ReactDOM = require('react-dom'),
    BenchStore = require('../stores/bench'),
    ApiUtil = require ('../util/apiUtil');

var Map = React.createClass({
  componentDidMount: function(){
    this._initializeMap()
    google.maps.event.addListener(this.map, 'idle', function () {
      ApiUtil.fetchBenches();
    });
    this.listenerToken = BenchStore.addListener(this._onChange);
  },

  _onChange: function () {
    var benches = BenchStore.all();
    benches.forEach(function (bench) {
      var pos = {lat: bench.lat, lng: bench.lng};
      var marker = new google.maps.Marker({
        position: pos,
        map: this.map,
        title: bench.description
        });
    }.bind(this));
  },

  _initializeMap: function () {
    var map = ReactDOM.findDOMNode(this.refs.map);
    var mapOptions = {
      center: {lat: 37.8664, lng: -122.2529356},
      zoom: 13
    };
    this.map = new google.maps.Map(map, mapOptions);
  },

  render: function () {
    return (<div className="map" ref="map"></div>);
  }
});

module.exports = Map;
