var React = require('react');
var History = require('react-router').History;
var PostActions = require('../actions/postActions.js');

module.exports = React.createClass({
  mixins: [History],

  showPost: function (event) {
    event.preventDefault();
    var url = "/posts/" + this.props.post.id.toString();
    this.history.pushState(null, url);
  },

  editPost: function (event) {
    event.preventDefault();
    var url = "/posts/" + this.props.post.id.toString() + "/edit";
    this.history.pushState(null, url);
  },

  deletePost: function (event) {
    event.preventDefault();
    PostActions.deletePost(this.props.post.id);
  },

  render: function () {
    var post = this.props.post;

    return (
      <li>
        <a href="#" onClick={this.showPost}>{post.title}</a>&nbsp;
        <button onClick={this.editPost}>Edit</button>&nbsp;
        <button onClick={this.deletePost}>Delete</button>
      </li>
    );
  }
});
