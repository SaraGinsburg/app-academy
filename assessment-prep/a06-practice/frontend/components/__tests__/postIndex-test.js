var React = require('react');
var ReactDOM = require('react-dom');

var TestUtils = require('react-addons-test-utils');
var expect = require('expect');
var rewireJasmine = require('../../__tests__/rewireJasmine');

xdescribe('post index', function () {
  var PostStore;
  var PostIndex;

  beforeEach(function () {
    PostStore = require('../../stores/postStore');
    PostIndex = require('../postIndex.jsx');

    this.posts = [
      { id: 1, title: "Title1" },
      { id: 2, title: "Title2" },
      { id: 3, title: "Title3" }
    ];

    this.listenerSpy = expect.spyOn(PostStore, 'addListener');

    this.allSpy = expect.spyOn(PostStore, 'all').andCall(function () {
      return this.posts;
    }.bind(this));

    expect.spyOn( $, 'ajax' ).andCall( function (params) { 
        params.success(this.posts);
    }.bind(this));

    var mockPostForm = React.createClass({
      render: function () {
        return <div className="fake-form">Fake Form</div>
      }
    });

    rewireJasmine.rewire(PostIndex, "PostForm", mockPostForm);

    this.component = TestUtils.renderIntoDocument(<PostIndex />);

    this.renderedDOM = function () {
      return ReactDOM.findDOMNode(this.component);
    }.bind(this)
  });

  afterEach(function () {
    expect.restoreSpies();
  });

  it('renders without problems', function () {
    expect(this.renderedDOM()).toExist();
  });


  it('contains the PostForm to create new posts', function () {
    var formMock = TestUtils.findRenderedDOMComponentWithClass(
      this.component,
      "fake-form"
    );

    expect(formMock.textContent).toEqual("Fake Form");
  });

  it('listens to the PostStore for changes', function () {
    let postContainer = this.renderedDOM().getElementsByTagName("li");

    expect(this.listenerSpy).toHaveBeenCalled();
    let callback = this.listenerSpy.calls[0].arguments[0];

    expect(postContainer.length).toEqual(0);

    callback(this.posts);

    expect(postContainer.length).toEqual(3);
  });

  it('lists the title of each post in a list index component', function () {
    this.component.setState({ posts: this.posts });
    let renderedPosts = this.renderedDOM().getElementsByTagName("li");

    expect(renderedPosts.length).toEqual(3);

    this.posts.forEach(function (post) {
      expect(this.renderedDOM().textContent).toContain(post.title);
    }.bind(this));
  });

});
