var React = require('react'),
    BenchStore = require('../stores/bench'),
    Map = require('./map.jsx'),
    FilterParamsStore = require('../stores/filterParams');

var Index = React.createClass({
  getInitialState: function () {
    return { benches: FilterParamsStore.filterBenches() };
  },

  componentDidMount: function () {
    this.listenerToken = BenchStore.addListener(this._onChange);
  },

  componentWillUnmount: function () {
    this.listenerToken.remove();
  },

  _onChange: function () {
    this.setState({
      benches: FilterParamsStore.filterBenches()
    });
  },

  render: function () {
    var benches = this.state.benches.map(function (bench, index) {
      return ( <li key={index}> {bench.description} </li> );
    });
    return (
      <ul>
        {benches}
      </ul>
    );
  }
});

module.exports = Index;
