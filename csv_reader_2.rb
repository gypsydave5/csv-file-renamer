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

csv.write_to_filename_format_array(1)
csv.write_to_filename_format_array(2)
csv.write_to_filename_format_array(3)

p csv.filename_format_array
p csv.generate_filename_format
