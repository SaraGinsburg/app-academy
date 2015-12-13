var Store = require('flux/utils').Store;
var PostConstants = require('../constants/postConstants.js');

var AppDispatcher = require('../dispatcher/dispatcher.js');

var PostStore = new Store(AppDispatcher);

// assign var _posts here

PostStore.all = function () {
};

PostStore.receiveAll = function() {
}

PostStore.find = function (id) {
};

PostStore.__onDispatch = function(payload) {
};

module.exports = PostStore;
