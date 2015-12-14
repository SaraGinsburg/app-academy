var PostConstants = require('../constants/postConstants.js');
var AppDispatcher = require('../dispatcher/dispatcher.js');

module.exports = {
  receiveAll: function (posts) {
    AppDispatcher.dispatcher({
      actionType: PostConstants.POSTS_RECEIVED,
      posts: posts
    });
  },

  receivePost: function (post) {
    AppDispatcher.dispatcher({
      actionType: PostConstants.POST_RECEIVED,
      post: post
    });
  },

  removePost: function (post) {
    AppDispatcher.dispatcher({
      actionType: PostConstants.POST_REMOVED,
      post: post
    });
  }
};
