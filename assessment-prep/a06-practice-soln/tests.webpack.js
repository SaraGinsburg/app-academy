var Immutable = require('immutable');

require('core-js/es5');

var projectContext = require.context(
    './frontend',
    true,
    /^((?!__tests__).)*.jsx?$/
);

var projectModuleIds = Immutable.Set(
  projectContext.keys().map(function (module) {
    String(projectContext.resolve(module))
  })
);

beforeEach(function () {
  projectModuleIds.forEach(function (id) { delete require.cache[id] });

  jasmine.clock().install();
});

afterEach(function () {
  jasmine.clock().uninstall();
});

var context = require.context('./frontend', true, /-test\.js?$/);
context.keys().forEach(context);
