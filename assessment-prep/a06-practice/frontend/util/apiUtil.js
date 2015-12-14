var PostActions = require('../actions/postActions.js');

module.exports = {
  fetchPosts: function () {
    $.ajax({
      url: "api/posts",
      method: "GET",
      success: function (posts) {
        PostActions.receiveAll(posts);
      }
    });
  },

  getPost: function (post) {
    var url = "api/posts/" + post.id;
    $.ajax({
      url: url,
      method: "GET",
      success: function (post) {
        PostActions.receivePost(post)
      }
    });
  },

  updatePost: function (post) {
    var url = "api/posts/" + post.id;
    $.ajax({
      url: url,
      method: "PATCH",
      success: function (newPost) {
        PostActions.receivePost(newPost)
      }
    });
  },


  createPost: function (post) {
    var url = "api/posts"
    $.ajax({
      url: url,
      method: "POST",
      data: {post: post},
      success: function (newPost) {
        PostActions.receivePost(newPost)
      }
    });
  },

  deletePost: function (id) {
    var url = "api/posts/" + id;
    $.ajax({
      url: url,
      method: "DELETE",
      success: function (post) {
        PostActions.removePost(post)
      }
    });
  }
}
