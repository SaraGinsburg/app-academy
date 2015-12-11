var React = require('react');
var ApiUtil = require('../../util/ApiUtil');
var PokemonStore = require('../../stores/pokemon');
var ToyIndexItem = require('./toyIndexItem');
var History = require('react-router').History;


var ToysIndex = React.createClass({
  mixins: [History],

  getInitialState: function () {
    return {pokemon: PokemonStore.find(parseInt(this.props.pokemon.id))};
  },

  _onChange: function () {
    this.setState({
      pokemon: PokemonStore.find(parseInt(this.props.pokemon.id))
    });
  },

  componentDidMount: function () {
    this.listenerToken = PokemonStore.addListener(this._onChange);
  },

  componentWillUnmount: function () {
    PokemonStore.remove(this.listenerToken);
  },

  render: function () {
    var pokemon = this.props.pokemon;

    if (!pokemon.toys) {
      return ( <div></div> );
    }

    var toys = Object.keys(pokemon.toys).map( function (idx) {
      return (
        <li className="toy-list-item" key={idx}>
          <ToyIndexItem
            pokemon={pokemon}
            toy={pokemon.toys[idx]}/>
        </li>
      );
    }.bind(this));

    return (
      <ul>
        {toys}
      </ul>
    );
  }


});

module.exports = ToysIndex;
