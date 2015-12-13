var Store = require('flux/utils').Store;
var Dispatcher = require('../dispatcher/dispatcher');
var BenchConstants = require('../constants/benchConstants');


var _benches = [];
var BenchStore = new Store(Dispatcher);

BenchStore.all = function () {
  return _benches.slice(0);
};

BenchStore.__onDispatch = function (payload) {
  switch (payload.actionType) {
    case BenchConstants.BENCHES_RECEIVED:
      resetBenches(payload.benches);
      break;
  }
}

var resetBenches = function (newBenches) {
  _benches = newBenches;
  console.log(_benches.length);
  BenchStore.__emitChange();
}

window.BenchStore = BenchStore;
module.exports = BenchStore
