/* eslint no-use-before-define:0 */
var Store = require('flux/utils').Store;
var AppDispatcher = require('../dispatcher/Dispatcher');

var TrackStore = new Store(AppDispatcher);
var _tracks = [];

TrackStore.all = function () {
  return _tracks.slice();
};

TrackStore.__onDispatch = function (payload) {
  switch (payload.actionType) {
    case "ADD_TRACK":
      addTrack(payload.track);
      break;
    // case "REMOVE_TRACK"
  }
};

var addTrack = function (track) {
  if (_tracks.indexOf(track) === -1){
    _tracks.push(track);
    TrackStore.__emitChange();
    console.log(_tracks);
  }
};

module.exports = TrackStore;
