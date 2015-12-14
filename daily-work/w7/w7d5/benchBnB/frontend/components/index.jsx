var React = require('react'),
    BenchStore = require('../stores/bench'),
    Map = require('./map.jsx');

var Index = React.createClass({
  getInitialState: function () {
    return { benches: BenchStore.all() };
  },

  componentDidMount: function () {
    this.listenerToken = BenchStore.addListener(this._onChange);
  },

  componentWillUnmount: function () {
    this.listenerToken.remove();
  },

  _onChange: function () {
    this.setState({
      benches: BenchStore.all()
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
