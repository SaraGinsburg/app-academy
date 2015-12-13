describe('a post index item', function () {
  var React = require('react');
  var ReactDOM = require('react-dom');

  var TestUtils = require('react-addons-test-utils');
  var expect = require('expect');

  var PostIndexItem;
  var PostStore;

  beforeEach(function () {
    PostIndexItem = require('../postIndexItem');
    PostStore = require('../../stores/postStore');

    this.post = {
      id: 1,
      title: "Title",
      body: "Body"
    };

    this.component = TestUtils.renderIntoDocument(
        <PostIndexItem post={this.post}/>
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

  it('contains a link to a show page', function () {
    var showLink = this.renderedDOM().querySelector('a');

    expect(showLink).toExist();
    expect(showLink.textContent).toEqual(this.post.title);
  });

  it('has an edit button', function () {
    var buttons = this.renderedDOM().querySelectorAll('button');
    var editButton;

    for (var i = 0; i < buttons.length; i++) {
      if (buttons[i].innerHTML === "Edit") {
        editButton = buttons[i];
      }
    }

    expect(editButton).toExist();
  });

  it('has a delete button', function () {
    var buttons = this.renderedDOM().querySelectorAll('button');
    var deleteButton;

    for (var i = 0; i < buttons.length; i++) {
      if (buttons[i].innerHTML === "Delete") {
        deleteButton = buttons[i];
      }
    }

    expect(deleteButton).toExist();
  });
});
