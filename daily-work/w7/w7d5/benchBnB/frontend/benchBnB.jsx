var React = require('react'),
    ReactDOM = require('react-dom'),
    Router = require('react-router').Router,
    Route = require('react-router').Route,
    IndexRoute = require('react-router').IndexRoute,
    Search = require('./components/search.jsx'),
    BenchForm = require('./components/benchForm.jsx'),
    ApiUtil = require('./util/apiUtil'),
    ApiActions = require('./actions/apiActions');

var App = React.createClass({
  render: function () {
    return (
      <div>
        <header><h1>BenchBnB</h1></header>
        {this.props.children}
      </div>
    );
  }
});


var routes = (
  <Route path="/" component={App}>
    <IndexRoute component={Search}/>
    <Route path="benches/new" component={BenchForm}/>
  </Route>
);

document.addEventListener("DOMContentLoaded", function () {
  ReactDOM.render(
    <Router>{routes}</Router>,
    document.getElementById('root')
  );
});
