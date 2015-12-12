var ApiActions = require('../actions/apiActions');

var ApiUtil = {
  fetchBenches: function () {
    $.get('api/benches', function (data) {
      ApiActions.receiveAllBenches(data)
    })
  }
}

module.exports = ApiUtil;
window.ApiUtil = ApiUtil;
