var React = require('react');

var TodoDetailView = React.createClass({
  render: function () {
    return (
      <div>
        <div>{this.props.body}</div>
        <button onClick={this.props.handleDestroy}>Delete</button>
      </div>
    );
  }
});

module.exports = TodoDetailView;
