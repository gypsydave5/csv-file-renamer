#!/usr/bin/ruby
require 'fileutils'

if ARGV.empty?
  print "Name of csv file to operate on: "
  filename = gets.chomp
else
  filename = ARGV.shift
end

csv_array = File.readlines(filename)
header = csv_array[0].split(",")
header.last.chomp!
p header
header.map!.with_index {|heading, position| [heading, position]}
header = Hash[*header.flatten]
p header

header_order = [3,2,1]

for line in csv_array[1..csv_array.length]
  p line
  p line.split(",")
  line_array= line.split(",")
  line_array.last.chomp!
  p line_array
  file_name = ""
  for title in header_order
    file_name = file_name + line_array[title]
  end
  p file_name
end