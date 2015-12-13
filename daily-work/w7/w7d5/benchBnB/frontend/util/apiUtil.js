var ApiActions = require('../actions/apiActions');

var ApiUtil = {
  fetchBenches: function (bounds) {
    var url = 'api/benches?' + $.param({bounds: bounds})
    console.log(url);
    $.get(url, function (data) {
      ApiActions.receiveAllBenches(data)
    })
  }
}

module.exports = ApiUtil;
window.ApiUtil = ApiUtil;
