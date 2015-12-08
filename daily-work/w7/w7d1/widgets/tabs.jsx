var React = require('react');

var Tabs = React.createClass({
  getInitialState: function() {
    return {selected: 0, tabs: this.props.tabs};
  },

  changeTab: function(index) {
    this.setState({selected: index});
  },

  render: function() {
    return(
      <div>
        <ul>
          {this.state.tabs.map(function(el, index){
            var title = el.title;
            if (index === this.state.selected) {
              title = <b>{el.title}</b>;
            }
            return <li onClick={this.changeTab.bind(this, index)}>{title}</li>;
          }.bind(this))}
        </ul>
        <article>
          {this.state.tabs[this.state.selected].content}
        </article>
      </div>
    );
  }
});

module.exports = Tabs;
