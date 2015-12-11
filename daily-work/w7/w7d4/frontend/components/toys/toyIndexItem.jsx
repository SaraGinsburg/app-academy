var React = require('react');
var History = require('react-router').History;
var ToyDetail = require('./ToyDetail');

var ToyIndexItem = React.createClass({
  mixins: [History],
  showDetail: function () {
    var ToyUrl = "pokemons/" + parseInt(this.props.pokemon.id) +
                    "/toys/" + this.props.toy.id;
    this.history.push(ToyUrl);
  },

  render: function () {
    return (
      <div onClick={this.showDetail}>
        Name: {this.props.toy.name}
      </div>
    );
  }
});


module.exports = ToyIndexItem;
