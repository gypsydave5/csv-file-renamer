#!/usr/bin/ruby
require 'fileutils'
require 'csv'

if ARGV.empty?
  print "Name of csv file to operate on: "
  filename = gets.chomp
else
  filename = ARGV.shift
end

csv_array = CSV.read(filename, headers: true)
p csv_array.headers
p csv_array
puts "\n------\nHeaders\n------\n"
puts "These are the headers of the csv file:\n"
csv_array.headers.each.with_index do
    |header, index| puts "#{index}: #{header}"
end

puts "\nPlease enter an index number to add the header to the new file name."
input = "1"
file_name_construct = []
while (input != "d") && (input != "")
  print "\nFile name is: "
  file_name_construct.each {|index| print "<" + csv_array.headers[index] + ">_"}
  puts "\nAvailable headers:"
  csv_array.headers.each.with_index do
    |header, index| puts "#{index}: #{header}"
  end
  puts "Next header ('d' when DONE, 'o' to start OVER): "
  input = gets.chomp
  case input
    when "o"
      file_name_construct = []
    else
      file_name_construct << input.to_i
  end
end

file_name_construct.pop
 print "\nFile name is: "
  file_name_construct.each {|index| print "<" + csv_array.headers[index] + ">_"}

