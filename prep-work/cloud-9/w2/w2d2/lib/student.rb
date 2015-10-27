class Student

  attr_accessor :first_name, :last_name, :courses

  def initialize(first, last)
    @first_name = first
    @last_name = last
    @courses = []
  end
  
  def name
    @first_name + " " + @last_name
  end
  
  def courses
    @courses
  end
  
  def enroll(course)
    unless @courses.include?(course)
      conflict = false
      self.courses.each{ |my_course| conflict = true if course.conflicts_with?(my_course)}
      if conflict
        raise "Course Conflict"
      else
        @courses.push(course)
        course.students.push(self)
      end
    end
  end
  
  def course_load
    credits = {}
    @courses.each do |course|
      if credits.include?(course.department)
        credits[course.department] += course.credits
      else
        credits[course.department] = course.credits
      end
    end
    credits
  end
    
end
