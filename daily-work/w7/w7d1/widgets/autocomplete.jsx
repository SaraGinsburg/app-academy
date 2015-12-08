var React = require('react');

var Autocomplete = React.createClass({
  getInitialState: function() {
    return {searchString: ''};
  },

  handleClick: function(e) {
    console.log(e);
    this.setState({searchString: e.target.textContent});
  },

  handleChange: function(e) {
    console.log("Target Value is: " + e.target.value);
    this.setState({searchString: e.target.value});
  },

  render: function() {
    var names = this.props.names;
    var searchString = this.state.searchString.trim().toLowerCase();
    if (searchString.length > 0) {
      names = names.filter(function(l){
        var regex = "^" + searchString;
        return l.toLowerCase().match(regex);
      });
    }

    return (
      <div>
        <input
          type="text"
          value={this.state.searchString}
          onChange={this.handleChange} placeholder="type here" />
        <ul>
          {
            names.map(function(l){
              return <li onClick={this.handleClick}>{l}</li>;
            }.bind(this))
          }
        </ul>
      </div>
    );
  }
});

module.exports = Autocomplete;
