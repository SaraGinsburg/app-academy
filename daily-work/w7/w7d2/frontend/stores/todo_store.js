var _todos = [],
    _callbacks = [];

var TodoStore = {
  changed: function () {
    _callbacks.forEach(function (cb) {
      cb();
    });
  },

  addChangeHandler: function (cb) {
    _callbacks.push(cb);
  },

  removeChangeHandler: function (cb) {
    var idx = _callbacks.indexOf(cb);
    if (idx !== -1) {
      _callbacks.splice(idx, 1);
    }
  },

  all: function () {
    return _todos;
  },

  fetch: function () {
    $.get('api/todos', {}, function (todos) {
      _todos = todos;
      TodoStore.changed();
    });
  },

  create: function (todo) {
    $.post('api/todos', todo, function (newTodo){
      _todos.push(newTodo);
      TodoStore.changed();
    });
  },

  find: function (id) {
    var targetIdx;

    _todos.forEach(function (todo, index) {
      if (todo.id === id) {
        targetIdx = index;
      }
    });

    return targetIdx;
  },

  destroy: function (id) {
    var toDelete = TodoStore.find(id);
    if (toDelete > -1) {
      $.ajax({
        url: 'api/todos/' + id.toString(),
        method: "DELETE",
        success: function () {
          _todos.splice(toDelete, 1);
          TodoStore.changed();
        },
        error: function (e) {
          console.log(e);
        }
      });
    }
  },

  toggleDone: function (id) {
    var updateIdx = TodoStore.find(id);

    if (updateIdx > -1) {
      var newStatus = !_todos[updateIdx].done;
      $.ajax({
        url: 'api/todos/' + id.toString(),
        method: "PATCH",
        data: {todo: {done: newStatus}},
        success: function () {
          _todos[updateIdx].done = newStatus;
          TodoStore.changed();
        },
        error: function (e) {
          console.log(e);
        }
      });
    }
  }


};

module.exports = TodoStore;
