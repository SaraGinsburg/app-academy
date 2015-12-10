var React = require('react');
var TodoStore = require('../stores/todo_store.js');
var DoneButton = require('./done_button.jsx');
var TodoDetailView = require('./todo_detail_view.jsx');

var TodoListItem = React.createClass({
  getInitialState: function () {
    return {details: false};
  },

  handleDestroy: function (e) {
    e.preventDefault();
    TodoStore.destroy(this.props.todo.id);
  },

  toggleDetails: function (e) {
    e.preventDefault();
    var currentDetails = this.state.details;

    this.setState({details: !currentDetails});
  },

  render: function() {
    var details = this.state.details ?
          <TodoDetailView body={this.props.todo.body}
            handleDestroy={this.handleDestroy}/> : "";

    return (
      <div>
        <div onClick={this.toggleDetails}>{this.props.todo.title}</div>
        {details}
        <DoneButton todo={this.props.todo}/>
      </div>
    );
  }
});

module.exports = TodoListItem;
