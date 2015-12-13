var React = require('react');
var PostStore = require('../stores/postStore.js');
var PostActions = require('../actions/postActions.js');
var Link = require('react-router').Link;

module.exports = React.createClass({
  getInitialState: function () {
    var potentialPost = PostStore.find(this.props.params.postId);
    var post = potentialPost ? potentialPost : {};
    return ({ title: post.title, body: post.body });
  },

  componentDidMount: function () {
    this.postListener = PostStore.addListener(this.handleChange);
    PostActions.getPost(parseInt(this.props.params.postId));
  },

  componentWillUnmount: function () {
    this.postListener.remove();
  },

  titleChange: function (event) {
    this.setState({ title: event.currentTarget.value });
  },

  bodyChange: function (event) {
    this.setState({ body: event.currentTarget.value });
  },

  handleChange: function () {
    var potentialPost = PostStore.find(this.props.params.postId);
    var post = potentialPost ? potentialPost : {}
    this.setState({ title: post.title, body: post.body });
  },

  handleSubmit: function (event) {
    event.preventDefault();
    var postData = {
      title: this.state.title,
      body: this.state.body,
      id: parseInt(this.props.params.postId)
    }
    PostActions.editPost(postData);
    this.props.history.pushState("/");
  },


  render: function () {
    return (
      <div>
        <form id="post-form" onSubmit={this.handleSubmit}>
          <input
            type="text"
            onChange={this.titleChange}
            value={this.state.title} />

          <br /><br />
          <textarea
            onChange={this.bodyChange}
            value={this.state.body} />

          <br /><br />

          <input type="submit" value="Save Changes"/>
        </form>

        <Link to="/">Back to Index</Link>
      </div>
     );
  }
});

