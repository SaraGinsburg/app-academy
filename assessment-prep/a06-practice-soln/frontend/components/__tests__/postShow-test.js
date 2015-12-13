describe('post show', function () {
  var React = require('react');
  var ReactDOM = require('react-dom');

  var TestUtils = require('react-addons-test-utils');
  var expect = require('expect');

  var PostShow;
  var PostStore;

  beforeEach(function () {
    PostShow = require('../postShow');
    PostStore = require('../../stores/postStore');

    this.post = {
      id: 1,
      title: "Title",
      body: "Body"
    };

    this.listenerSpy = expect.spyOn(PostStore, 'addListener');

    expect.spyOn( $, 'ajax').andCall(function (params) {
      params.success(this.post);
    }.bind(this));

    var fakeParams = { postId: this.post.id };

    this.component = TestUtils.renderIntoDocument(
        <PostShow params={fakeParams}/>
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

  it('contains the post information', function () {
    var renderedText = this.renderedDOM().textContent;

    expect(renderedText).toInclude(this.post.title);
    expect(renderedText).toInclude(this.post.body);
  });

  // TODO: Figure out how to test this
  // it('links back to the index', function () {
  //   debugger
  // });

  // it('listens to the post store', function () {
  //   let showEl = this.renderedDOM();
  //   expect(this.listenerSpy).toHaveBeenCalled();
  //   let callback = this.listenerSpy.calls[0].arguments[0];
  //
  //   callback(this.post);
  //   this.component.setState(callback.__reactBoundContext.state);
  //   expect().toEqual(3);
  // });
});
