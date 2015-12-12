var ApiActions = require('../actions/pokemonActions');
var PokemonStore = require('../stores/pokemon');

var fetchAllPokemons = function () {
  $.ajax({
    url: 'api/pokemon',
    success: function (data) {
      ApiActions.receiveAllPokemons(data);
    }
  });
};

var fetchPokemon = function(pokemonId) {
  var pokemonUrl = 'api/pokemon/' + pokemonId;
  $.ajax({
    url: pokemonUrl,
    success: function (data){
      ApiActions.receivePokemon(data);
    }
  });
};



module.exports = {
  fetchAllPokemons: fetchAllPokemons,
  fetchPokemon: fetchPokemon
};
