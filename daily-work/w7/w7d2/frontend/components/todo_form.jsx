var React = require('react');
var TodoStore = require('../stores/todo_store.js');

var TodoForm = React.createClass({
  getInitialState: function () {
    return {title: "", body: ""};
  },

  updateTitle: function (e) {
    this.setState({title: e.target.value});
  },

  updateBody: function (e) {
    this.setState({body: e.target.value});
  },

  handleSubmit: function (e) {
    e.preventDefault();
    TodoStore.create({todo: {title: this.state.title,
                      body: this.state.body,
                      done: false}});
    this.setState({title: "", body: ""});
  },

  render: function () {
    return (
      <form onSubmit={this.handleSubmit}>
        <label>Title: <br/>
          <input type="text"
            onChange={this.updateTitle}
            value={this.state.title} />
        </label>

        <br/>

        <label>
          Todo: <br/>
          <textarea onChange={this.updateBody}
                    value={this.state.body}/>
        </label>

        <br/>

        <input type="submit" value="Add a Todo"></input>

      </form>
    );
  }
});

module.exports = TodoForm;
