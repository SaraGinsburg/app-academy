var Dispatcher = require('../dispatcher/dispatcher.js');
var BenchConstants = require('../constants/benchConstants');

var ApiActions = {
  receiveAllBenches: function (data) {
    Dispatcher.dispatch({
      actionType: BenchConstants.BENCHES_RECEIVED,
      benches: data
    });
  }
};

module.exports = ApiActions;
window.ApiActions = ApiActions;
