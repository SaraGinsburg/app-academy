class XmlDocument
  # TODO: your code goes here!
  
  attr_reader :string, :indent, :current_indent
  
  def initialize(indent = false)
    @string = ""
    @indent = indent
    @current_indent = 0
  end
  
  def hello(options = {}, &prc)
    name_tag = ""
    if options.include?(:name)
      name_tag = " name=\"#{options[:name]}\""
    end
    
    if !prc.nil?
      if @indent
        current = @current_indent
        @current_indent += 1
        tag = "#{"  " * current}<hello#{name_tag}>\n#{prc.call}#{"  " * current}</hello>\n"
        return tag
      else
        return "<hello#{name_tag}>#{prc.call}</hello>"
      end
    end
    
    if @indent
      return "<hello/>\n"
    else
      return "<hello#{name_tag}/>"
    end
  end
  
  def method_missing(method_name, options = {}, &prc)
    method_name = method_name.to_s
    
    option = ""
    if !(options == {})
      key = options.keys.first
      option = " #{key}=\"#{options[key]}\""
    end
    
    if !prc.nil?
      if @indent
        current = @current_indent
        @current_indent += 1
        tag = "#{"  " * current}<#{method_name}#{option}>\n#{prc.call}#{"  " * current}</#{method_name}>\n"
        return tag
      else
        return "<#{method_name}#{option}>#{prc.call}</#{method_name}>"
      end
    end
    
    if @indent
      current = @current_indent
      @current_indent += 1
      return "#{"  " * current}<#{method_name}#{option}/>\n"
    end
    
    "<#{method_name}#{option}/>"
  end

  
end
