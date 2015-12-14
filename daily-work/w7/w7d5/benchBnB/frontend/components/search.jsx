var React = require('react'),
    BenchStore = require('../stores/bench'),
    ApiUtil = require ('../util/apiUtil'),
    Map = require('./map.jsx'),
    Index = require('./index.jsx'),
    BenchForm = require('./benchForm.jsx');

var Search = React.createClass({
  render: function () {
    return (
      <div>
        <Map/>
        <Index/>
      </div>
    );
  }
});

module.exports = Search;
