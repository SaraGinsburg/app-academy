var React = require('react');
var PostActions = require('../actions/postActions.js');

module.exports = React.createClass({
  getInitialState: function () {
    return ({ title: "", body: "" });
  },

  titleChange: function (event) {
    var newTitle = event.currentTarget.value;
    this.setState({ title: newTitle });
  },

  bodyChange: function (event) {
    var newBody = event.currentTarget.value;
    this.setState({ body: newBody });
  },

  handleSubmit: function (event) {
    event.preventDefault();
    var postData = {
      title: this.state.title,
      body: this.state.body
    };
    PostActions.createPost(postData);
    this.setState({ title: "", body: "" });
  },

  render: function () {
    return (
      <div>
        <h3>New Post</h3>
        <form onSubmit={this.handleSubmit}>
          <input
            type="text"
            value={this.state.title}
            onInput={this.titleChange} />

          <br /><br />

          <textarea
            value={this.state.body}
            onInput={this.bodyChange} />

          <br /><br />

          <input type="submit" value="Create Post" />
        </form>
      </div>
    );
  }
});
