var React = require('react');
var PostStore = require('../stores/postStore.js');
var PostActions = require('../actions/postActions.js');
var Link = require('react-router').Link;

module.exports = React.createClass({
  getInitialState: function() {
    // this.props.params is available here with the post id.
    // For example, this.props.params = { postId: 1 };
    return {};
  },

  render: function() {
    return (
      <div>
        // Code goes here. Don't remove the div.
      </div>
    )
  }
});
