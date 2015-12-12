var React = require('react'),
    ReactDOM = require('react-dom'),
    // Router = require('react-router').Router,
    // Route = require('react-router').Route,
    Search = require('./components/search.jsx'),
    ApiUtil = require('./util/apiUtil'),
    ApiActions = require('./actions/apiActions');

// var RouterApp = (
//   <Router>
//     // <Route path="\" component={App} />
//   </Router>
// );

document.addEventListener("DOMContentLoaded", function () {
  ReactDOM.render(
    <Search/>,
    document.getElementById('root')
  );
});
