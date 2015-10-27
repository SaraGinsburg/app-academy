lines = File.readlines(ARGV[0])

line_count = lines.size
text = lines.join

char_count = text.length
char_count_no_spaces = text.gsub(/\s+/,'').length
word_count = text.split(' ').length
sentence_count = text.split(/\.|\?|!/).length
paragraph_count = text.split(/\n\n/).length
wps = word_count / sentence_count
spp = sentence_count / paragraph_count

puts line_count
puts char_count
puts char_count_no_spaces
puts word_count
puts paragraph_count
puts sentence_count
puts spp
puts wps

