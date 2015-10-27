class Dictionary
  # TODO: your code goes here!
  attr_accessor :entries
  def initialize()
    @entries = {}
  end
  
  def add(entry)
    if entry.class == Hash
      entry.each{|key, value| self.entries[key] = value}
    else
      self.entries[entry] = nil
    end
  end
  
  def keywords
    entries.keys.sort
  end
  
  def include?(entry)
    entries.include?(entry)
  end
  
  def find(entry)
    matches = {}
    keywords.each{ |key| matches[key] = entries[key] if key.include?(entry)}
    matches
  end
  
  def printable
    str = ""
    keywords.each { |key| str << "[#{key}] \"#{self.entries[key]}\"\n"}
    str.chomp
  end
end
