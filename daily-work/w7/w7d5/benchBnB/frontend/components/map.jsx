var React = require('react'),
    ReactDOM = require('react-dom'),
    BenchStore = require('../stores/bench'),
    ApiUtil = require ('../util/apiUtil');

var Map = React.createClass({
  getInitialState: function () {
      return {markers: []};
  },

  componentDidMount: function(){
    this._initializeMap()

    this.mapListenerToken = google.maps.event.addListener(
      this.map,
      'idle',
      function () {
        ApiUtil.fetchBenches(this.generateMapBoundaries());
      }.bind(this)
    );

    this.listenerToken = BenchStore.addListener(this._onChange);
  },

  generateMapBoundaries: function () {
    var bounds = this.map.getBounds();
    return {
      southWest: {
        lat: bounds.getSouthWest().lat(),
        lng: bounds.getSouthWest().lng()
      },
      northEast: {
        lat: bounds.getNorthEast().lat(),
        lng: bounds.getNorthEast().lng()
      },
    }
  },

  componentWillUnmount: function () {
    BenchStore.remove(this.ListenerToken);
    google.maps.event.removeListener(this.mapListenerToken)
  },

  clearMarkers: function () {
    console.log("old: " + this.state.markers.length);
    this.state.markers.forEach(function (marker) {
      if (!this.map.getBounds().contains(marker.position)) {
        marker.setMap(null);
        marker = null
      }
    }.bind(this));
  },

  _onChange: function () {
    this.clearMarkers();
    var benches = BenchStore.all();
    this.setState({markers:
      benches.map(function (bench) {
        var pos = {lat: bench.lat, lng: bench.lng};
        return new google.maps.Marker({
          position: pos,
          map: this.map,
          title: bench.description
        });
      }.bind(this))
    });
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
    console.log("new: " + this.state.markers.length);
    return (<div className="map" ref="map"></div>);
  }
});

module.exports = Map;
