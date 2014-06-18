#!/usr/bin/ruby
require 'fileutils'

class File_rename_csv

  require 'csv.rb'

  attr_accessor :seperator, :test_braces, :extension, :array_of_files

  attr_reader :filename_format_array

  @filename_format_array = []
  @seperator = "_"
  @test_braces = ["<",">"]
  @extension = ""
  @filename_format = ""
  @headers = []
  @array_of_files = []

  def initialize(csv_file)
    @csv_array = CSV.read(csv_file)
    @headers = @csv_array[0]
  end

  def generate_filename_format
    @filename_format = ""
    @filename_format << @test_braces[0] + @headers[@filename_format_array.first] + braces[1]
    @filename_format_array.drop(1).each do |header|
      @filename_format << @seperator + braces[0] + @headers[header] + braces[1]
    end
    @filename_format << extension
  end

  def write_to_filename_format_array(input)
    if (input.class != Fixnum) || input > @headers.size
      throw "Invalid input"
    else
      @filename_format_array << input
    end
  end

  def reformat_filename (filename)
    filename.gsub! (/\s/) , "-"
  end

  if ARGV.empty?
    print "Name of csv file to operate on: "
    filename = gets.chomp
  else
    filename = ARGV.shift
  end
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

filepath = ""
while !File.directory?(filepath)
print "\nPlease enter file path to file(s) to be renamed (or ENTER for current): "
filepath = gets.chomp
  if filepath == ""
    filepath = "."
  end
  puts "Invalid path!\n" if !File.directory?(filepath)
end
Dir.chdir(filepath)
puts "Changing files in #{Dir.pwd}\n"
print "\nWhich files would you like to rename?\nPlease enter search string (or ENTER for all): "
search_string = gets.chomp

if search_string == ""
  search_string = "*.*"
end

file_array = Dir[search_string]
p file_array.sort! {|x, y| x.to_i <=> y.to_i }

puts "Extension for new files (return to maintain current): "
file_extension = gets.chomp

if file_extension != ""
  file_rename_map = {}
  file_array.each.with_index do |file, index|
    file_rename_map[file] = generate_file_name(file_name_construct, csv_array, index + 1) + file_extension
  end
  else
  file_rename_map = {}
  file_array.each.with_index do |file, index|
    extension = file.match (/\..*/)
    file_rename_map[file] = generate_file_name(file_name_construct, csv_array, index + 1) + extension[0]
  end
end

p file_rename_map

file_rename_map.each do |old_name, new_name|
  puts "renaming #{old_name} to #{new_name}"
  File.rename old_name, new_name
end

puts "\n\nall done now -- bye!"
