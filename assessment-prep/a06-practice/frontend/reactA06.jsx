import { Router, Route, IndexRoute, Link } from 'react-router'

var React = require('react');
var ReactDOM = require('react-dom');

var PostIndex = require('./components/postIndex.jsx');
var PostShow = require('./components/postShow.jsx');
var PostEdit = require('./components/postEdit.jsx');

var App = React.createClass({
  render: function () {
    return (<div>
        <h1>React/Flux Assessment</h1>
      </div>);
  }
});

var routes = (
  <Router>
  </Router>
);

// Render the React Router into the the div with id "content" on
// the "DOMContentLoaded" event
