var React = require('react');
var PokemonStore = require('../../stores/pokemon');
var ApiUtil = require('../../util/apiUtil.js');
var ToysIndex = require('../toys/toysIndex');

var PokemonDetail = React.createClass({

  getInitialState: function() {
    return {pokemon: this.getStateFromStore()};
  },

  getStateFromStore: function() {
    return PokemonStore.find(this.props.params.pokemonId);
  },

  _onChange: function () {
    this.setState({
      pokemon: this.getStateFromStore()
    });
  },

  componentDidMount: function () {
    // ApiUtil.fetchPokemon(parseInt(this.props.param.pokemonId));
    this.listenerToken = PokemonStore.addListener(this._onChange);
  },

  componentWillUnmount: function () {
    PokemonStore.remove(this.listenerToken);
  },

  componentWillReceiveProps: function(newProps) {
    var pokemonId = parseInt(newProps.params.pokemonId);
    ApiUtil.fetchPokemon(pokemonId);
    this.setState({pokemon: PokemonStore.find(pokemonId)});
  },

  render: function() {
    var details;
    if(this.state.pokemon)
    {
      details = (
        <div>
          <img src={this.state.pokemon.image_url}/>
          Name: {this.state.pokemon.name}
          <br/>
          Type: {this.state.pokemon.poke_type}
          <br/>
          Attack: {this.state.pokemon.attack}
          <br/>
          Defense: {this.state.pokemon.defense}
          <br/>
          Moves: <br/>
          <ul>
            {
              this.state.pokemon.moves.map(function (move, index) {
                return <li key={index}>-{move}</li>;
              })
            }
          </ul>
        </div>
      );
    } else {
      details = <div></div>;
    }

    return (
      <div>
        <div className="pokemon-detail-pane">
          <div className="detail">
            {details}
          </div>
          <ToysIndex
            pokemon={this.state.pokemon}/>
        </div>
        {this.props.children}
      </div>
    );
  }
});
module.exports = PokemonDetail;
