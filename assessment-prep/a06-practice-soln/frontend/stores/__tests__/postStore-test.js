var React = require('react');
var ReactDOM = require('react-dom');

var TestUtils = require('react-addons-test-utils');
var expect = require('expect');

describe('post store', function () {
  var PostStore;
  var PostActions;

  beforeEach(function () {
    PostActions = require('../../actions/postActions');
    PostStore = require('../postStore');

    PostStore.__set__("_posts", {});

    this.posts = {
      1: { id: 1, title: "Post1", body: "Body1" },
      2: { id: 2, title: "Post2", body: "Body2" }
    };
  });

  it('can return an array of stored posts', function () {
    PostStore.__set__("_posts", this.posts);

    var foundPosts = {};
    PostStore.all().forEach(function (post) {
      foundPosts[post.id] = post;
    });

    Object.keys(this.posts).forEach(function (postId) {
      expect(foundPosts[postId]).toEqual(this.posts[postId]);
    }.bind(this));
  });

  it('can find a post by id', function () {
    PostStore.__set__("_posts", this.posts);

    let post = PostStore.find(2);

    expect(post.title).toEqual("Post2");
    expect(post.body).toEqual("Body2");
  });

  it('can receive a post', function () {
    let post = { id: 3, title: "Title3", body: "Body3" };

    PostActions.receivePost(post);
    
    expect(PostStore.find(3)).toBe(post);
  });

  it('can receive a collection of posts', function () {
    let newPosts = [
      {id: 4, title: "NewTitle 1"},
      {id: 5, title: "NewTitle 2"},
      {id: 6, title: "NewTitle 3"}
    ];

    PostActions.receiveAll(newPosts);

    newPosts.forEach(function (post) {
      expect(PostStore.all()).toInclude(post);
    });
  });
});
