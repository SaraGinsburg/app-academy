var React = require('react');
var PostStore = require('../stores/postStore.js');
var PostActions = require('../actions/postActions.js');
var Link = require('react-router').Link;

var PostShow = React.createClass({
  getInitialState: function () {
    var potentialPost = PostStore.find(this.props.params.postId);
    return ({post: potentialPost ? potentialPost : {}});
  },

  componentDidMount: function () {
    this.postListener = PostStore.addListener(this.handleChange);
    PostActions.getPost(parseInt(this.props.params.postId));
  },

  componentWillUnmount: function () {
    this.postListener.remove();
  },

  handleChange: function () {
    var potentialPost = PostStore.find(this.props.params.postId);
    this.setState({ post: potentialPost ? potentialPost : {} });
  },

  render: function () {
    var post = this.state.post;
    return (
      <div id="post-container">
        <h3>{post.title}</h3>
        <p>{post.body}</p>
        <Link to="/">Back to Index</Link>
      </div>
    );
  }
});

module.exports = PostShow;
