var React = require('react');
var PokemonStore = require('../../stores/pokemon');
var ApiUtil = require('../../util/apiUtil.js');

var ToyDetail = React.createClass({
  getInitialState: function () {
    return {toy: this.getStateFromStore()};
  },

  getStateFromStore: function () {
    var pokemon = PokemonStore.find(this.props.params.pokemonId);
    var toysId = parseInt(this.props.params.toysId);
    return this.findToy(pokemon, toysId);
  },

  _onChange: function () {
    this.setState({
      toy: this.getStateFromStore()
    });
  },

  componentDidMount: function () {
    this.listenerToken = PokemonStore.addListener(this._onChange);
  },

  componentWillUnmount: function () {
    PokemonStore.remove(this.listenerToken);
  },

  componentWillReceiveProps: function (newProps) {
    var toysId = parseInt(newProps.params.toysId);
    var pokemon = PokemonStore.find(newProps.params.pokemonId);
    this.setState({toy: this.findToy(pokemon, toysId)});
  },

  findToy: function (pokemon, toysId) {
    var targetToy;
    pokemon.toys.forEach(function (toy, index) {
      if(toy.id === toysId){
        targetToy = toy;
      }
    });

    return targetToy;
  },

  render: function () {
    var toy = this.state.toy;

    if(!toy){ return <div></div>; }

    return (
      <div className="toy-detail-pane">
        <img src={toy.image_url}/>
        <div>
          Name: {toy.name}
          <br/>
          Happiness: {toy.happiness}
          <br/>
          Price: {toy.price}
        </div>
      </div>
    );
  }
});

module.exports = ToyDetail;
