class Book
  # TODO: your code goes here!
  
  attr_reader :title
  
  def initialize
    @title = ""
  end
  
  def title=(title)
    
    stay_low = %w{and in the of a an}
    
    title_arr = title.capitalize.split(' ')
    title_arr.map! do |word|
      if !stay_low.include?(word)
        word.capitalize 
      else
        word
      end
    end
    @title = title_arr.join(' ')
    
  end

  
end
