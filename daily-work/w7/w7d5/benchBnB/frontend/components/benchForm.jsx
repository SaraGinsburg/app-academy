var React = require('react'),
    ApiUtil = require('../util/ApiUtil.js');

var BenchForm = React.createClass({
  getInitialState: function () {
    return { lat: "", lng: "", description: "", seating: 1 };
  },

  handleSubmit: function (e) {
    e.preventDefault();
    ApiUtil.createBench(this.state);
    this.setState({ lat: "", lng: "", description: "", seating: 1 });
  },

  handleChange: function (e) {
    var change = {};
    change[e.target.name] = e.target.value;
    this.setState(change);
  },

  render: function () {
    return (
      <form onSubmit={this.handleSubmit}>
        <label>
          Latitude: <br/>
        <input type="text" name="lat" onChange={this.handleChange}/>
        </label>
        <br/>
        <label>
          Longitude: <br/>
        <input type="text" name="lng" onChange={this.handleChange}/>
        </label>
        <br/>
        <label>
          Description: <br/>
        <textarea name="description"
                  onChange={this.handleChange}/>
        </label>
        <br/>
        <label>
          Seating: <br/>
        <input type="number" defaultValue="1" min="1" size="3" name="seating"
               onChange={this.handleChange}/>
        </label>
        <br/>
        <input type="submit" value="Add Bench!"/>
        <br/><br/>
      </form>
    )
  }
});

module.exports = BenchForm
