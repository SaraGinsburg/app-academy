var Dispatcher = require('../dispatcher/dispatcher.js');
var PokemonConstants = require('../constants/pokemonConstants');


var receiveAllPokemons = function (data) {

  Dispatcher.dispatch({
    actionType: PokemonConstants.POKEMONS_RECEIVED,
    pokemons: data
  });

};

var receivePokemon = function (data) {

  Dispatcher.dispatch({
    actionType: PokemonConstants.POKEMON_RECEIVED,
    pokemon: data

  });
};



module.exports = {
  receiveAllPokemons: receiveAllPokemons,
receivePokemon: receivePokemon};
