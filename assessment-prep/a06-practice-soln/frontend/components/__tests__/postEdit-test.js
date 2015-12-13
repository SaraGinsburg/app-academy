describe('post edit', function () {
  var React = require('react');
  var ReactDOM = require('react-dom');

  var TestUtils = require('react-addons-test-utils');
  var expect = require('expect');

  var PostEdit;
  var PostStore;

  beforeEach(function () {
    PostEdit = require('../postEdit');
    PostStore = require('../../stores/postStore');

    this.post = {
      id: 1,
      title: "Title",
      body: "Body"
    };

    var fakeParams = { postId: this.post.id };

    this.listenerSpy = expect.spyOn(PostStore, 'addListener');

    this.findSpy = expect.spyOn(PostStore, 'find').andCall(function () {
      return this.post;
    }.bind(this));

    expect.spyOn( $, 'ajax' ).andCall( function (params) { 
      params.success(this.post);
    }.bind(this));

    this.component = TestUtils.renderIntoDocument(
        <PostEdit params={fakeParams} />
    );

    this.renderedDOM = function () {
      return ReactDOM.findDOMNode(this.component);
    }.bind(this);
  });

  afterEach(function () {
    expect.restoreSpies();
  });

  it('renders without problems', function () {
    expect(this.renderedDOM()).toExist();
  });

  it('contains title and body fields', function () {
    this.component.setState({ title: "TestTitle", body: "TestBody" });
    var inputNodes = this.renderedDOM().querySelector('form').childNodes;
    let inputValues = [];

    for (var i = 0; i < inputNodes.length; i++) {
      if (inputNodes[i].value) {
        inputValues.push(inputNodes[i].value);
      }
    }

    expect(inputValues).toInclude("TestTitle");
    expect(inputValues).toInclude("TestBody");
  });

  it('prefills post data from the store', function () {
    expect(this.findSpy).toHaveBeenCalledWith(this.post.id);

    var inputNodes = this.renderedDOM().querySelector('form').childNodes;
    let inputValues = [];

    for (var i = 0; i < inputNodes.length; i++) {
      if (inputNodes[i].value) {
        inputValues.push(inputNodes[i].value);
      }
    }

    expect(inputValues).toInclude("Title");
    expect(inputValues).toInclude("Body");
  });
});
