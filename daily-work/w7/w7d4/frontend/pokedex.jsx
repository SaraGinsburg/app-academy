var React = require('react');
var ReactDOM = require('react-dom');
var Router = require('react-router').Router;
var Route = require('react-router').Route;
var App = require('./components/app');
var PokemonDetail = require('./components/pokemons/pokemonDetail');
var ToyDetail = require('./components/toys/toyDetail');

var routerApp = (
  <Router>
    <Route path="/" component={App}>
      <Route path="pokemons/:pokemonId" component={PokemonDetail}>
        <Route path="toys/:toysId" component={ToyDetail}></Route>
      </Route>
    </Route>
  </Router>
);


document.addEventListener("DOMContentLoaded", function(){
  ReactDOM.render(
    routerApp,
    document.getElementById('root')
  );
});
