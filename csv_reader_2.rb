#!/usr/bin/ruby
require 'fileutils'
require './csv_reader_class.rb'

if ARGV.empty?
  print "Name of csv file to operate on: "
  filename = gets.chomp
else
  filename = ARGV.shift
end

csv = File_rename_csv.new(filename)

input = "bob"
while input != ""
  puts "Interactive mode \n\n"
  print "Current file name format: "
  csv.generate_filename_format
  print csv.filename_format
  puts "\n\navailable headers are:"
  csv.headers.each.with_index do |header, index|
    puts "#{index}: #{header}"
  end
  print "\nPlease enter index of next header in file name\n(hit RETURN when DONE,'o' to start OVER, 'd' to delete last header): "
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


