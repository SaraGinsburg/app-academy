xdescribe('post show', function () {
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

  it('fetches the post with an ajax request through apiUtil and renders the post information', function () {
    var renderedText = this.renderedDOM().textContent;

    expect(renderedText).toInclude(this.post.title);
    expect(renderedText).toInclude(this.post.body);
  });

});
