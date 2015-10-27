class Timer
  attr_accessor :seconds
  
  def initialize(seconds = 0)
    @seconds = seconds
  end
  
  def time_string
    readings = {}
    readings[:seconds] = seconds % 60
    readings[:hours] = seconds / (60*60)
    readings[:minutes] = seconds / 60 - readings[:hours] * 60
    
    
    for key, value in readings
      readings[key] = ( "0" + value.to_s) if value.to_s.length == 1
    end
    
    "#{readings[:hours]}:#{readings[:minutes]}:#{readings[:seconds]}"
  end
    
end