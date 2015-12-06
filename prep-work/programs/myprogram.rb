#!/usr/bin/env ruby

=begin
class Sample
  def hello
    puts "Hello, World!"
  end
end

s = Sample.new
s.hello

5.times do |i|
  puts "Hello, Wo#{i}rld!"
end

def water_status(minutes)
  if minutes < 7
    puts "The water is not boiling yet."
  elsif minutes == 7
    puts "It's just barely boiling"
  elsif minutes == 8
    puts "It's boiling!"
  else
    puts "Hot! Hot! Hot!"
  end
end

10.times do |i|
	water_status(i)
end


class Student
  attr_accessor :first_name, :last_name, :primary_phone_number

  def introduction
    puts "Hi, I'm #{first_name}!"
  end

  def favorite_number
    7
  end
end

frank = Student.new
frank.first_name = "Frank"
frank.introduction



puts "Frank's favorite number is #{frank.favorite_number}."
=end

def say_hello(name)
  puts "Hey there, #{name}!"
end

if $PROGRAM_NAME == __FILE__
  name = gets.chomp
  say_hello(name)
end
