class Temperature
  # TODO: your code goes here!
  
  attr_reader :celsius, :fahrenheit
  
  def initialize(options={})
    if(!options[:f].nil?)
      @fahrenheit = options[:f]
      @celsius = (5.0/9.0) * (options[:f] - 32)
    else
      @celsius = options[:c]
      @fahrenheit = options[:c] * (9.0/5.0) + 32
    end
  end
  
  def in_celsius
    celsius
  end
  
  def in_fahrenheit
    fahrenheit
  end
  
  def self.from_fahrenheit(deg)
    self.new(:f => deg)
  end
  
  def self.from_celsius(deg)
    self.new(:c => deg)
  end
end

class Celsius < Temperature
  def initialize(deg)
    super(:c => deg)
  end
end

class Fahrenheit < Temperature
  def initialize(deg)
    super(:f => deg)
  end
end



