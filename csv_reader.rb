#!/usr/bin/ruby
require 'fileutils'
require 'csv'

def generate_file_name(file_format_array, csv_name, row_number, seperator="_", braces=["",""])
  file_name = ""
  file_name << braces[0] + csv_name[row_number][file_format_array.first] + braces[1]
  file_format_array.drop(1).each do |index|
    file_name << seperator
    file_name << braces[0] + csv_name[row_number][index] + braces[1]
  end
  file_name
end

if ARGV.empty?
  print "Name of csv file to operate on: "
  filename = gets.chomp
else
  filename = ARGV.shift
end

csv_array = CSV.read(filename)
p csv_array[0]
p csv_array
puts "\n------\nHeaders\n------\n"
puts "These are the headers of the csv file:\n"
csv_array[0].each.with_index do
    |header, index| puts "#{index}: #{header}"
end

puts "\nPlease enter an index number to add the header to the new file name."
input = "1"
file_name_construct = []
while input != ""
    if !(file_name_construct.empty?) && (file_name_construct.last >= csv_array[0].length)
        puts "\nInvalid index number... reverting"
    file_name_construct.pop
    end
  if file_name_construct.empty?  puts "No file format currently created"
  else
  print "\nFile name format is: "
  print generate_file_name(file_name_construct, csv_array, 0, "_", ["<",">"])
  end
  puts "\nAvailable headers:"
  csv_array[0].each.with_index do
    |header, index| puts "#{index}: #{header}"
  end
  print "Next header (hit RETURN when DONE, 'o' to start OVER, 'd' to delete last header): "
  input = gets.chomp
  case input
    when "o"
      file_name_construct = []
    when "d"
      file_name_construct.pop
    else
      file_name_construct << input.to_i
  end
end

file_name_construct.pop
print "\nFile name format is: "
puts generate_file_name(file_name_construct, csv_array, 0, "_", ["<",">"])


