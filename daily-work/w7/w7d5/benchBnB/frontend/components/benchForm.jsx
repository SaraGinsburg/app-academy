var React = require('react'),
    ApiUtil = require('../util/ApiUtil.js');

var BenchForm = React.createClass({
  getInitialState: function () {
    return {
      lat: this.props.location.query.lat || "",
      lng: this.props.location.query.lng || "",
      description: "",
      seating: 1
    };
  },

  handleSubmit: function (e) {
    e.preventDefault();
    var newBench = this.state;

    // ["lat", "lng", "seating"].forEach(function (attr) {
    //   newBench[attr] = parseFloat(newBench[attr]);
    // });

    newBench.lat = parseFloat(newBench.lat);
    newBench.lng = parseFloat(newBench.lng);
    newBench.seating = parseFloat(newBench.seating);

    ApiUtil.createBench(newBench);
    this.setState({ lat: "", lng: "", description: "", seating: 1 });
  },

  handleChange: function (e) {
    var change = {};
    change[e.target.name] = e.target.value;
    this.setState(change);
  },

  render: function () {
    console.log(this.state);
    return (
      <form onSubmit={this.handleSubmit}>
        <label>
          Latitude: <br/>
        <input type="text"
          name="lat"
          onChange={this.handleChange}
          defaultValue={this.state.lat}/>
        </label>
        <br/>
        <label>
          Longitude: <br/>
        <input type="text"
          name="lng"
          onChange={this.handleChange}
          defaultValue={this.state.lng}/>
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
        <input type="number"
          defaultValue="1"
          min="1"
          max="100"
          size="3"
          name="seating"
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
