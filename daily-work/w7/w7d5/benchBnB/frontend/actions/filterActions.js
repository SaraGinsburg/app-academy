var Dispatcher = require('../dispatcher/dispatcher.js'),
    FilterConstants = require('../constants/benchConstants.js');

var FilterActions = {
  receiveNewBounds: function (data) {
    Dispatcher.dispatch({
      actionType: FilterConstants.NEW_BOUNDS_RECEIVED,
      bounds: data
    });
  },

  receiveNewRange: function (data) {
    Dispatcher.dispatch({
      actionType: FilterConstants.NEW_RANGE_RECEIVED,
      range: data
    });
  },
};

window.FilterActions = FilterActions;
module.exports = FilterActions
