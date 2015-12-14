var React = require('react');
var PostStore = require('../stores/postStore.js');
var PostActions = require('../actions/postActions.js');

var PostIndexItem = require('./postIndexItem.jsx');
var PostForm = require('./postForm.jsx');

module.exports = React.createClass({
  getInitialState: function() {
    return {posts: []};
  },

  render: function() {
    return (
      <ul>
      
      </ul>
    );
  }

});
