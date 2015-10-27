class Fixnum
  $words = {
    0 => "zero", 1 => "one", 2 => "two", 3 => "three", 4 => "four",
    5 => "five", 6 => "six", 7 => "seven", 8 => "eight", 9 => "nine",
    
    10 => "ten", 11 => "eleven", 12 => "twelve", 13 => "thirteen", 
    14 => "fourteen", 15 => "fifteen", 16 => "sixteen", 17 => "seventeen",
    18 => "eighteen", 19 => "nineteen",    
    
    20 => "twenty", 30 => "thirty", 40 => "forty", 50 => "fifty", 
    60 => "sixty", 70 => "seventy", 80 => "eighty", 90 => "ninety"
    
  }
  
  $thousand_powers = ["", "thousand", "million", "billion", "trillion"]
  
  def in_words
    return $words[self] if $words.include?(self)
    
    #separate triplets
    number_str = self.to_s
    
    if number_str.length % 3 == 1
      number_str = "00" + number_str
    elsif number_str.length % 3 == 2
      number_str = "0" + number_str
    end
    
    triplets = number_str.scan(/.{1,3}/m)
    
    
    #evaluate triplets
    triplets.each_with_index{ |triplet, i| triplets[i] = "#{eval_triplet(triplet)}".strip}
    
    
    #combine triplets
    str = ""
    power = triplets.length - 1
    
    for i in (0..power)
      str << "#{triplets[i]} #{$thousand_powers[power - i]} " unless triplets[i] == ""
    end
    
    
    str.strip
  end
  
  def eval_triplet(triplet)
    str = ""
    
    str << "#{$words[triplet[0].to_i]} hundred " unless triplet[0] == "0"
    
    if triplet[1] == "1"
      str << "#{$words[triplet[1..2].to_i]}"
    else
      str << "#{$words[triplet[1].to_i*10]} " unless triplet[1] == "0"
      str << "#{$words[triplet[2].to_i]}" unless triplet[2] == "0"
    end
    
    str
  end
    
  
end