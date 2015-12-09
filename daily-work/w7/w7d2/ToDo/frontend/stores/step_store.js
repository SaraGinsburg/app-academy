var _steps = {},
    _callbacks = [];

var StepStore = {
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

  fetch: function (todoId) {
    var url = "api/todos/" + todoId.toString() + "/steps";
    
    $.get(url, {},
      function(steps) {
        _steps[todoId] = steps;
        StepStore.changed();
      }
    );
  },

  all: function (todoId) {
    return _steps[todoId];
  },

  create: function (step) {
    $.post("api/todos/" + step.todo_id.toString() + "/steps", step,
      function (newStep) {
        _steps[newStep.todo_id].push(newStep);
        StepStore.changed();
      }
    );
  },

  find: function (id) {
    var targetIdx, todoId;

    _steps.keys().forEach(function (currentTodoId) {
      _steps[currentTodoId].forEach(function (step, index) {
        if (step.id === id) {
          targetIdx = index;
          todoId = currentTodoId;
        }
      });
    });

    return {targetIdx: targetIdx, todoId: todoId};
  },

  destroy: function (id) {
    var toDelete = StepStore.find(id);

    if(toDelete){
      $.ajax({
        url: 'api/steps' + id.toString(),
        method: "DELETE",
        success: function () {
          _steps[toDelete.todoId].splice(toDelete.targetIdx, 1);
          StepStore.changed();
        },
        error: function (e) {
          console.log(e);
        }
      });
    }
  },

  toggleDone: function (id) {
    var toUpdate = StepStore.find(id);

    if (toUpdate) {
      var newStatus = !_steps[toUpdate.todoId][toUpdate.targetIdx].done;
      $.ajax({
        url: 'api/steps/' + id.toString(),
        method: "PATCH",
        data: {step: {done: newStatus}},
        success: function () {
          _steps[toUpdate.todoId][toUpdate.targetIdx].done = newStatus;
          StepStore.changed();
        },
        error: function (e) {
          console.log(e);
        }
      });
    }
  }
};


module.exports = StepStore;
