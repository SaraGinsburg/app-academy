var React = require('react'),
    LinkedStateMixin = require('react-addons-linked-state-mixin');


var FilterParams = React.createClass({
  mixins: [LinkedStateMixin],

  getInitialState: function () {
    return {
      min: this.props.range.min,
      max: this.props.range.max
    };
  },
  render: function () {
    FilterParamsStore.updateBounds({
      min: parseInt(this.state.range.min),
      max: parseInt(this.state.range.max)
    });

    return (
      <div>
        <strong>Seating: </strong>
        <label>
          Minimum:
          <input type="text"
            placeholder={this.props.range.min}
            valueLink={this.linkState("min")}/>
        </label>
        <label>
          Maximum:
          <input type="text"
            placeholder={this.props.range.max}
            valueLink={this.linkState("max")}/>
        </label>
      </div>
    );
  }
});

module.exports = FilterParams;
