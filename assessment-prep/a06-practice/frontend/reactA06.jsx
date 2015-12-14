import { Router, Route, IndexRoute, Link } from 'react-router'

var React = require('react');
var ReactDOM = require('react-dom');

var PostIndex = require('./components/postIndex.jsx');
var PostShow = require('./components/postShow.jsx');
var PostEdit = require('./components/postEdit.jsx');

var App = React.createClass({
  render: function () {
    return (
      <div>
        <h1>React/Flux Assessment</h1>
        {this.props.children}
      </div>
    );
  }
});

var routes = (
  <Router>
    <Route path="/" component={App}>
      <IndexRoute component={PostIndex}/>
        <Route path="posts" component={PostIndex} />
        <Route path="posts/:postId/edit" component={PostEdit} />
        <Route path="posts/:postId" component={PostShow} />
    </Route>
  </Router>
);

// Render the React Router into the the div with id "content" on
// the "DOMContentLoaded" event
document.addEventListener('DOMContentLoaded', function () {
  ReactDOM.render(
    routes,
    document.getElementById('content')
  );
});
