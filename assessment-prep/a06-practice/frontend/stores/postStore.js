var Store = require('flux/utils').Store;
var PostConstants = require('../constants/postConstants.js');

var AppDispatcher = require('../dispatcher/dispatcher.js');

var PostStore = new Store(AppDispatcher);

// assign var _posts here
_posts = {}

PostStore.all = function () {
  // return _posts.slice(0);
};

PostStore.receiveAll = function() {

}

PostStore.find = function (id) {
  // var target;
  // _posts.forEach(function (post) {
  //   if (post.id === id) {
  //     target = post;
  //   }
  // });
  // return target;
};

PostStore.__onDispatch = function(payload) {

};

module.exports = PostStore;
