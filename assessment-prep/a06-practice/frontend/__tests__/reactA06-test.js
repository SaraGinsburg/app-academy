xdescribe('router', function () {
  var React = require('react');
  var ReactDOM = require('react-dom');
  var Router = require('react-router').Router;

  var expect = require('expect');
  var TestUtils = require('react-addons-test-utils');

  var rewireJasmine = require('./rewireJasmine');

  var Entry;

  beforeEach(function () {
    expect.spyOn(document, "addEventListener");
    expect.spyOn( $, 'ajax');

    Entry = require('../reactA06');

    this.router = TestUtils.renderIntoDocument(
      <Router>
        { Entry.__get__("routes") }
      </Router>
    );
  });

  afterEach(function () {
    expect.restoreSpies();
  });

  it('has a root route to the App component', function () {
    var App = Entry.__get__("App");

    this.router.history.match(
      { pathname: "/" },
      function (arg1, arg2, matched) {
        expect(matched.components).toInclude(App);
      }
    );
  });

  it('matches \"/posts\" to the PostIndex component', function () {
    var PostIndex = require('../components/postIndex');

    this.router.history.match(
      { pathname: "/posts" },
      function (arg1, arg2, matched) {
        expect(matched.components).toInclude(PostIndex);
      }
    );
  });

  it('matches \"/posts/:postId\" to the PostShow component', function () {
    var PostShow = require('../components/postShow');

    this.router.history.match(
      { pathname: "/posts/1" },
      function (arg1, arg2, matched) {
        expect(matched.components).toInclude(PostShow);
      }
    );
  });

  it('matches \"/posts/:postId/edit\" to the PostEdit component', function () {
    var PostEdit = require('../components/postEdit');

    this.router.history.match(
      { pathname: "/posts/1/edit" },
      function (arg1, arg2, matchedRoutes) {
        expect(matchedRoutes).toExist();
        expect(matchedRoutes.components).toInclude(PostEdit);
      }
    );
  });
});
