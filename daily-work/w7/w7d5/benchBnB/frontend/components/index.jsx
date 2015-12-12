var React = require('react'),
    BenchStore = require('../stores/bench'),
    ApiUtil = require ('../util/apiUtil'),
    Map = require('./map.jsx');

var Index = React.createClass({
  getInitialState: function () {
    return { benches: BenchStore.all() };
  },

  componentDidMount: function () {
    this.listenerToken = BenchStore.addListener(this._onChange);
    ApiUtil.fetchBenches();
  },

  componentWillUnmount: function () {
    BenchStore.remove(this.listenerToken);
  },

  _onChange: function () {
    this.setState({
      benches: BenchStore.all()
    });
  },

  render: function () {
    return (
      <div>
        Index
      </div>
    );
  }
});

module.exports = Index;
