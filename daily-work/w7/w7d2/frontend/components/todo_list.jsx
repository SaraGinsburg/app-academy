var React = require('react');
var TodoStore = require('../stores/todo_store.js');
var TodoListItem = require('./todo_list_item.jsx');
var TodoForm = require('./todo_form.jsx');

var TodoList = React.createClass({
  getInitialState: function() {
    return {list: TodoStore.all()};
  },

  todosChanged: function() {
    this.setState({list: TodoStore.all()});
  },

  componentDidMount: function() {
    TodoStore.addChangeHandler(this.todosChanged);
    TodoStore.fetch();
  },

  componentWillUnmount: function() {
    TodoStore.removeChangeHandler(this.todosChanged);
  },

  render: function() {
    var todoListItems = this.state.list.map(function(todo) {
      return <TodoListItem key={todo.id} todo={todo}/>;
    });

    return (
      <div>
        {todoListItems}
        <TodoForm/>
      </div>
    );
  }
});

module.exports = TodoList;
