var TodoList = require('./components/todo_list.jsx');
var React = require('react');
var ReactDOM = require('react-dom');
StepStore = require('./stores/step_store.js');

$(function () {
  ReactDOM.render(
    <TodoList/>,
    document.getElementById('root')
  );
});
