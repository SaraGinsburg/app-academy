class RPNCalculator
  # TODO: your code goes here!
  attr_accessor :orders
  
  def initialize()
    @orders = []
  end
  
  def push(num)
    self.orders.push(num)
    self
  end
  
  def plus
    raise "calculator is empty" if orders.length < 2
    orders.push(:+)
  end
  
  def minus
    raise "calculator is empty" if orders.length < 2
    orders.push(:-)
  end
  
  def times
    raise "calculator is empty" if orders.length < 2
    orders.push(:*)
  end
  
  def divide
    raise "calculator is empty" if orders.length < 2
    orders.push(:/)
  end
  
  def value
    arr = orders.dup
    total = 0
    #p arr
    
    i = 0
    
    until i == arr.length
      if arr[i].class == Symbol
       # p arr[i]
        
        arr[i - 2] = eval(arr[i - 2], arr[i - 1], arr[i])
        total = arr[i - 2]        
        
        arr.delete_at(i)
        arr.delete_at(i - 1)
        
        i = 0
      else
        i += 1
      end
    end
    total
  end
  
  def eval(num1, num2, operation)
    if operation == :+
      return num1 + num2
    elsif operation == :-
      return num1 - num2
    elsif operation == :*
      return num1 * num2
    else
      return num1 * 1.0 / num2
    end
  end
    
  def tokens(str)
    arr = str.split(' ')
    for i in (0..arr.length - 1)
      if arr[i] == "/"
        arr[i] = :/
      elsif arr[i] == "+"
        arr[i] = :+
      elsif arr[i] == "-"
        arr[i] = :-
      elsif arr[i] == "*"
        arr[i] = :*
      else
        arr[i] = arr[i].to_i
      end
    end
    @orders = arr
    arr
  end
  
  def evaluate(str)
    tokens(str)
    value
  end
  
end


if __FILE__ == $PROGRAM_NAME
  calculator = RPNCalculator.new
  
  if ARGV.count > 0
    #file input
    file_name = ARGV[0]
    File.foreach(file_name) do |line|
      puts calculator.evaluate(line)
    end
    
  else
    #command line app
    commands = []
    complete = false
    while !complete
      command = gets.chomp
      if command == ""
        complete = true
      else
        commands.push(command)
      end
    end
    puts calculator.evaluate(commands.join(' '))
  end
  
end