var React = require('react'),
    BenchStore = require('../stores/bench'),
    ApiUtil = require ('../util/apiUtil'),
    Map = require('./map.jsx'),
    Index = require('./index.jsx');

var Search = React.createClass({
  render: function () {
    return (
      <div>
        <Index/>
        <Map/>
      </div>
    );
  }
});

module.exports = Search;
