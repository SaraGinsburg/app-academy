describe('post form', function () {
  var React = require('react');
  var ReactDOM = require('react-dom');

  var TestUtils = require('react-addons-test-utils');
  var expect = require('expect');

  var PostForm;
  var PostStore;

  beforeEach(function () {
    PostForm = require('../postForm');
    PostStore = require('../../stores/postStore');

    this.newPost = {
      id: 1,
      title: "Title",
      body: "Body"
    };

    this.component = TestUtils.renderIntoDocument(<PostForm />);

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
});
