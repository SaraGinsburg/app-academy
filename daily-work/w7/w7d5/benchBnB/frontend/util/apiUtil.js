var ApiActions = require('../actions/apiActions');

var ApiUtil = {
  fetchBenches: function (bounds) {
    var url = 'api/benches?' + $.param({bounds: bounds})
    $.get(url, function (data) {
      ApiActions.receiveAllBenches(data)
    })
  },

  createBench: function (bench) {
    $.post(
      "api/benches",
      {bench: bench},
      function (newBench) {
        console.log(newBench);
        ApiActions.createBench(newBench);
      }
    );
  }
}

module.exports = ApiUtil;
window.ApiUtil = ApiUtil;
