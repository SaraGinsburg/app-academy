
/* eslint no-use-before-define:0 */
var Store = require('flux/utils').Store;
var AppDispatcher = require('../dispatcher/dispatcher');
var PokemonStore = new Store (AppDispatcher);
var PokemonConstants = require('../constants/pokemonConstants');

var _pokemons = {};

PokemonStore.__onDispatch = function (payload) {
  switch(payload.actionType) {
    case PokemonConstants.POKEMONS_RECEIVED:
      resetPokemons(payload.pokemons);
      break;
    case PokemonConstants.POKEMON_RECEIVED:
      resetPokemon(payload.pokemon);
      break;
}

};

PokemonStore.find = function (id){
  return _pokemons[parseInt(id)];
};


PokemonStore.all = function ()
{
  var keys = Object.keys(_pokemons);
  return keys.map(function (key) {
    return _pokemons[key];
  }).slice(0);

};

var resetPokemons = function (newPokemons) {
  var newPokedex = {};

  newPokemons.forEach(function (pokemon) {
    newPokedex[parseInt(pokemon.id)] = pokemon;
  });

  _pokemons = newPokedex;
  PokemonStore.__emitChange();

};

var resetPokemon = function (newPokemon) {
  _pokemons[parseInt(newPokemon.id)] = newPokemon;
  PokemonStore.__emitChange();
};




module.exports = PokemonStore;
