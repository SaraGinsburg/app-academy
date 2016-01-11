var React = require('react'),
    ReactDOM = require('react-dom'),
    BenchStore = require('../stores/bench'),
    FilterParamsStore = require('../stores/filterParams'),
    ApiUtil = require ('../util/apiUtil'),
    FilterParamsUtil = require('../util/filterParamsUtil');

var Map = React.createClass({

  getInitialState: function () {
      return {markers: []};
  },

  componentDidMount: function(){
    this._initializeMap()

    this.idleListenerToken = google.maps.event.addListener(
      this.map,
      'idle',
      function () {
        var newBounds = this.generateMapBoundaries();

        //is there a way to refactor into one fxn
        ApiUtil.fetchBenches(newBounds);
        FilterParamsUtil.changeBounds(newBounds);
      }.bind(this)
    );

    this.clickListenerToken = google.maps.event.addListener(
      this.map,
      'click',
      function (e) {
        this.props.clickHandler(e.latLng);
      }.bind(this)
    );

    this.benchListenerToken = BenchStore.addListener(this._onChange);
    this.filterListenerToken = FilterParamsStore.addListener(this._onChange);
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
    this.benchListenerToken.remove();
    google.maps.event.removeListener(this.idleListenerToken)
  },

  clearMarkers: function () {
    console.log("old: " + this.state.markers.length);
    this.state.markers.forEach(function (marker) {
      // if (!this.map.getBounds().contains(marker.position)) {
        marker.setMap(null);
        marker = null
      // }
    }.bind(this));
  },

  _onChange: function () {
    this.clearMarkers();
    var benches = FilterParamsStore.filterBenches();

    this.setState({ markers:
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
