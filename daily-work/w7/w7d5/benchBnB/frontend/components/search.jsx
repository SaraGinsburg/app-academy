var React = require('react'),
    BenchStore = require('../stores/bench'),
    ApiUtil = require ('../util/apiUtil'),
    Map = require('./map.jsx'),
    Index = require('./index.jsx'),
    BenchForm = require('./benchForm.jsx'),
    FilterParamsStore = require('../stores/filterParams'),
    FilterParams = require('./FilterParams.jsx');

var Search = React.createClass({
  getInitialState: function () {
    return {};
  },

  componentDidMount: function () {
    this.filterListenerToken =
      FilterParamsStore.addListener(this._onFilterChange);
  },

  componentWillUnmount: function () {
    this.filterListenerToken.remove();
  },

  _onFilterChange: function () {
    this.setState(FilterParamsStore.params())
  },

  clickMapHandler: function (coords) {
    console.log(coords.lat());
    console.log(coords.lng());
    this.props.history.pushState(null, "benches/new", {
      lat: coords.lat(),
      lng: coords.lng()
    });
  },

  render: function () {
    return (
      <div>
        <p>{JSON.stringify(this.state)}</p>
        <FilterParams range={this.state.range}/>
        <Map clickHandler={this.clickMapHandler}/>
        <Index/>
      </div>
    );
  }
});

module.exports = Search;
