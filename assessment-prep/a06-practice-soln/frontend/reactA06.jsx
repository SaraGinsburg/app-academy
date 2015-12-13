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
        {this.props.children}
      </div>);
  }
});

var routes = (
  <Route path="/" component={App}>
    <IndexRoute component={PostIndex} />
    <Route path="posts" component={PostIndex} />
    <Route path="posts/:postId/edit" component={PostEdit} />
    <Route path="posts/:postId" component={PostShow} />
  </Route>
);

document.addEventListener("DOMContentLoaded", function () {
  var root = document.getElementById("content");

  ReactDOM.render(<Router>{routes}</Router>, root);
});
