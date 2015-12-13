var PostConstants = require('../constants/postConstants.js');
var AppDispatcher = require('../dispatcher/dispatcher.js');

module.exports = {
  fetchPosts: function () {
    ApiUtil.fetchPosts();
  },

  getPost: function (id) {
    ApiUtil.getPost(id);
  },

  createPost: function (data) {
    ApiUtil.createPost(data);
  },

  editPost: function (data) {
    ApiUtil.updatePost(data);
  },

  deletePost: function (id) {
    ApiUtil.deletePost(id);
  },

  receiveAll: function (posts) {
    AppDispatcher.dispatch({
      actionType: PostConstants.POSTS_RECEIVED,
      posts: posts
    });
  },

  receivePost: function (post) {
    AppDispatcher.dispatch({
      actionType: PostConstants.POST_RECEIVED,
      post: post
    });
  },

  removePost: function (post) {
    AppDispatcher.dispatch({
      actionType: PostConstants.POST_REMOVED,
      post: post
    });
  }
}

var ApiUtil = require('../util/apiUtil.js');
