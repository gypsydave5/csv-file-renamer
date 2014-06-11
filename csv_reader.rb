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
