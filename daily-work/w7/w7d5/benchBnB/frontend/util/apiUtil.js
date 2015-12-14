var ApiActions = require('../actions/apiActions');

var ApiUtil = {
  fetchBenches: function (bounds) {
    var url = 'api/benches?' + $.param({bounds: bounds})
    console.log(url);
    $.get(url, function (data) {
      ApiActions.receiveAllBenches(data)
    })
  },

  createBench: function (bench) {
    $.post(
      "api/benches",
      {bench: bench},
      function (bench) {
        ApiActions.createBench(bench)
      }
    );
  }
}

module.exports = ApiUtil;
window.ApiUtil = ApiUtil;
