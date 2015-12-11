var React = require('react');
var History = require('react-router').History;

var PokemonIndexItem = React.createClass({
  mixins: [History],

  showDetail: function () {
    var pokemonUrl = "pokemons/" + this.props.pokemon.id;
    this.history.push(pokemonUrl);

  },



  render: function () {
    return (
      <li className="poke-list-item" onClick={this.showDetail}>
        Name: {this.props.pokemon.name} <br/>
        Poketype: {this.props.pokemon.poke_type}
      </li>
    );
  }
});






module.exports = PokemonIndexItem;
