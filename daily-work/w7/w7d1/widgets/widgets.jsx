var React = require('react');
var ReactDOM = require('react-dom');
var Autocomplete = require('./autocomplete.jsx');
var WeatherClock = require('./weatherclock.jsx');
var Tabs = require('./tabs.jsx');

var Widgets = React.createClass({
  render: function() {
    return (
      <div>
        <Autocomplete names={names}/>
        <WeatherClock/>
        <Tabs tabs={tabs}/>
      </div>
    );
  }
});

var names = [
  "Bart Simpson",
  "Homer Simpson",
  "Ranier Wolfcastle",
  "Kent Brockman",
  "Kevin Duffman",
  "Jeff Albertson",
  "Herschel Krustovsky",
  "Milhouse Van Houton",
  "Julius Hibbert",
  "Ralph Wiggum"
];

var tabs = [
  { title: "Milhouse", content: "Bury me at Makeout Creek"},
  { title: "Ralph", content: "This is where I saw the lepruchaun.  He told me to burn things."},
  { title: "Bart", content: "Women are easy.  State capitols are hard."}
];

document.addEventListener("DOMContentLoaded", function(){
  ReactDOM.render(
    <Widgets/>,
    document.getElementById('main')
  );
});
