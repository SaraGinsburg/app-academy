var Store = require('flux/utils').Store,
    Dispatcher = require('../dispatcher/dispatcher'),
    FilterConstants = require('../constants/benchConstants.js'),
    BenchStore = require('./bench.js');


var _filterParams = {bounds: {}, range:{min: 1, max: 10}};

var FilterParamsStore = new Store(Dispatcher);


FilterParamsStore.__onDispatch = function (payload) {
  switch (payload.actionType) {
    case FilterConstants.NEW_BOUNDS_RECEIVED:
      updateBounds(payload.bounds);
      break;
    case FilterConstants.NEW_RANGE_RECEIVED:
      updateRange(payload.range);
  }
}

FilterParamsStore.params = function () {
  var paramsCopy = {};
  Object.keys(_filterParams).forEach(function (key) {
    paramsCopy[key] = _filterParams[key];
  });
  return paramsCopy;
}

FilterParamsStore.filterBenches = function () {
  return BenchStore.all().filter(function (bench) {
    return bench.seating <= _filterParams.range.max &&
            bench.seating >= _filterParams.range.min;
  });
}

var updateBounds = function (newBounds) {
  _filterParams.bounds = newBounds
  FilterParamsStore.__emitChange();
}

var updateRange = function (newRange) {
  _filterParams.range = newRange
  FilterParamsStore.__emitChange();
}

window.FilterParamsStore = FilterParamsStore;
module.exports = FilterParamsStore
