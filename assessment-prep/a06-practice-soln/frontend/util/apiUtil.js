var PostActions = require('../actions/postActions.js');

module.exports = {
  fetchPosts: function () {
    $.ajax({
      url: "api/posts",
      success: function (posts) {
        PostActions.receiveAll(posts);
      }
    });
  },

  getPost: function (id) {
    $.ajax({
      url: "api/posts/" + id.toString(),
      success: function (post) {
        PostActions.receivePost(post);
      }
    });
  },

  createPost: function (data) {
    $.ajax({
      url: "api/posts",
      type: "POST",
      data: { post: data },
      success: function (post) {
        PostActions.receivePost(post);
      }
    });
  },

  updatePost: function (data) {
    $.ajax({
      url: "api/posts/" + data.id,
      type: "PATCH",
      data: { post: { title: data.title, body: data.body } },
      success: function (post) {
        PostActions.receivePost(post);
      }
    });
  },

  deletePost: function (id) {
    $.ajax({
      url: "api/posts/" + id,
      type: "DELETE",
      success: function (post) {
        PostActions.removePost(post);
      }
    });
  }
}

