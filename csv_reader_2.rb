#!/usr/bin/ruby
require 'fileutils'
require './csv_reader_class.rb'
require './csv_reader_cont.rb'

if ARGV.empty?
  print "Name of csv file to operate on: "
  filename = gets.chomp
else
  filename = ARGV.shift
end

csv = File_rename_csv.new(filename)

input = "1"
while input != ""
  puts "Interactive mode \n\n"
  print "Current file name format: "
  csv.generate_filename_format
  print csv.filename_format
  puts "\n\navailable headers are:"
  csv.headers.each.with_index do |header, index|
    puts "#{index}: #{header}"
  end
  print "\nPlease enter index of next header in file name\n(hit RETURN when DONE,'o' to start OVER, 'd' to DELETE last header): "
  input = gets.chomp
  case input
    when "o"
      csv.filename_format_reset
    when "d"
      csv.filename_format_remove_last
    else
      csv.write_to_filename_format_array(input)
  end
end

if csv.target_directory.empty?
  puts "Please enter target directory: "
  input = gets.chomp
  csv.target_directory = input
  puts "Target directory set to #{csv.target_directory}"
end

if csv.read_extension.empty?
    puts "Select extension of files to target (hit return for all files): "
    input = gets.chomp
    csv.read_extension = input
    puts "Target file extension is #{csv.read_extension}"
end

puts "Loading file names..."

csv.load_filenames

puts "Files loaded and sorted: "
p csv.array_of_files

p csv.generate_filename(1)
#p csv.generate_filename(2)
p csv.generate_filename(3)
p csv.generate_filename(4)
p csv.generate_filename(6)
p csv.generate_filename(7)
p csv.generate_filename(8)
p csv.generate_filename(9)
p csv.generate_filename(10)
p csv.create_rename_map
p csv.file_rename_map
