function Clock () {
  // 1. Create a Date object.
  var date = new Date();
  // 2. Store the hours, minutes, and seconds.
  this.hours = date.getHours();
  this.minutes = date.getMinutes();
  this.seconds = date.getSeconds();
  // 3. Call printTime.
  this.printTime();
  // 4. Schedule the tick at 1 second intervals.

  setInterval(this._tick.myBind(this), 1000);
}

Function.prototype.myBind = function (context) {
  var fn = this;
  return function () {
    return fn.apply(context);
  };
};

Clock.prototype.printTime = function () {
  // Format the time in HH:MM:SS
  var time = formatTime(this.hours) + ":" + formatTime(this.minutes) +
    ":" + formatTime(this.seconds);
  // Use console.log to print it.
  console.log(time);
};

var formatTime = function(dial){
  if (dial < 10){
    return "0" + dial;
  } else {
    return dial;
  }
};

Clock.prototype._tick = function () {
  // 1. Increment the time by one second.
  this.seconds ++;

  if (this.seconds === 60){
    this.seconds = 0;
    this.minutes ++;
  }

  if (this.minutes === 60) {
    this.minutes = 0;
    this.hours ++;
  }

  if(this.hours === 24){
    this.hours = 0;
  }
  // 2. Call printTime.
  this.printTime();
};

var clock = new Clock();
