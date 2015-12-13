var rewires = [];
var rewireJasmine = {
  rewire: function(mod, variableName, newVariableValue){
    var originalVariableValue = mod.__get__(variableName);


    rewires.push({
      mod: mod,
      variableName: variableName,
      originalVariableValue: originalVariableValue,
      newVariableValue: newVariableValue
    });

    mod.__set__(variableName, newVariableValue);
  },

  unwireAll: function(){
    for (var i = 0; i < rewires.length; i++) {
      var mod = rewires[i].mod,
        variableName = rewires[i].variableName,
        originalVariableValue = rewires[i].originalVariableValue;

      mod.__set__(variableName, originalVariableValue);
    }
  }
};

afterEach(function(){
  rewireJasmine.unwireAll();

  rewires = [];
});

module.exports = rewireJasmine;
