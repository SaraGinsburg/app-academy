var React = require('react');
var TodoStore = require('../stores/todo_store.js');

var DoneButton = React.createClass({

  handleDone: function(e) {
    e.preventDefault();
    TodoStore.toggleDone(this.props.todo.id);
  },

  render: function () {
    var buttonText = this.props.todo.done ? "Undo" : "Done";

    return (
      <button onClick={this.handleDone}>{buttonText}</button>
    );
  }
});

module.exports = DoneButton;
