var Store = require('flux/utils').Store;
var PostConstants = require('../constants/postConstants.js');

var AppDispatcher = require('../dispatcher/dispatcher.js');
var PostStore = new Store(AppDispatcher);

var _posts = {};

var resetPosts = function (posts) {
  _posts = {};

  posts.forEach(function (post) {
    _posts[post.id] = post;
  });
};

var setPost = function (post) {
  _posts[post.id] = post;
};

var removePost = function (post) {
  delete _posts[post.id];
};

PostStore.all = function () {
  return Object.keys(_posts).map(function (postId) {
    return _posts[postId];
  });
};

PostStore.find = function (id) {
  return _posts[id];
};


PostStore.__onDispatch = function (payload) {
  switch (payload.actionType) {
    case PostConstants.POSTS_RECEIVED:
      resetPosts(payload.posts);
      break;
    case PostConstants.POST_RECEIVED:
      setPost(payload.post);
      break;
    case PostConstants.POST_REMOVED:
      removePost(payload.post);
      break;
  }
  PostStore.__emitChange();
};

module.exports = PostStore;
