var FilterActions = require('../actions/filterActions');

var FilterParamsUtil = {
  changeBounds: function (bounds) {
    FilterActions.receiveNewBounds(bounds)
  },

  changeRange: function (range) {
    FilterActions.receiveNewRange(range)
  }
}

module.exports = FilterParamsUtil;
window.FilterParamsUtil = FilterParamsUtil;
