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

def check_format_array(file_format_array, csv_name)
  file_format_array.each do |index|
    if index >= csv_name[0].length
      return false
    end
  end
  return true
end

if ARGV.empty?
  print "Name of csv file to operate on: "
  filename = gets.chomp
else
  filename = ARGV.shift
end

csv_array = CSV.read(filename)

input = "1"
file_name_construct = []
while input != ""
  if (!check_format_array(file_name_construct, csv_array)) || (input.to_i.to_s != input)
    puts "\nInvalid input ... reverting..."
    file_name_construct.pop
  end
  if file_name_construct.empty?
    puts "No file format currently created"
  else
  print "\nFile name format is: "
  print generate_file_name(file_name_construct, csv_array, 0, "_", ["<",">"])
  end
  puts "\nAvailable headers:\n"
  csv_array[0].each.with_index do
    |header, index| puts "#{index}: #{header}"
  end
  print "\nPlease enter index of next header in file name\n(hit RETURN when DONE, 'o' to start OVER, 'd' to delete last header): "
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
if file_name_construct.empty?
  puts "No format created for renaming operation. Exiting..."
  exit
end
print "\nFile name format is: "
puts generate_file_name(file_name_construct, csv_array, 0, "_", ["<",">"])

print "\nPlease enter file path of file(s) to be renamed (or ENTER for current): "
filepath = gets.chomp
if filepath == ""
  filepath = "."
end

print "\nWhich files would you like to rename?\nPlease enter search string (or ENTER for all): "
Dir.chdir(filepath)
search_string = gets.chomp

if search_string == ""
  search_string = "*.*"
end

file_array = Dir[search_string]
p file_array.sort! {|x, y| x.to_i <=> y.to_i }

file_rename_map = {}
file_array.each.with_index do |file, index|
  file_rename_map[file] = generate_file_name(file_name_construct, csv_array, index + 1)
end

p file_rename_map


