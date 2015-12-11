var React = require('react');
var ApiUtil = require('../../util/ApiUtil');
var PokemonStore = require('../../stores/pokemon');
var PokemonIndexItem = require('./pokemonIndexItem');


var PokemonsIndex = React.createClass({
  getInitialState: function () {
    return { pokemons: PokemonStore.all() };
  },

  componentDidMount: function () {
    ApiUtil.fetchAllPokemons();
    this.storeListener = PokemonStore.addListener(this._onChange);
  },

  _onChange: function () {
    this.setState({pokemons: PokemonStore.all()});
  },

  componentWillUnmount:function () {
    PokemonStore.remove(this.storeListener);
  },

  render: function () {
    var indexItems = Object.keys(this.state.pokemons).map(function (key) {
      return (
        <PokemonIndexItem
          key={this.state.pokemons[key].id}
          pokemon={this.state.pokemons[key]}/>
      );
    }.bind(this));

    return (
      <ul>
        {indexItems}
      </ul>
    );
  }
});

module.exports = PokemonsIndex;
