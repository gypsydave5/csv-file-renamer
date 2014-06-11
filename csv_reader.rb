#!/usr/bin/ruby
require 'fileutils'
require 'CSV'

if ARGV.empty?
  print "Name of csv file to operate on: "
  filename = gets.chomp
  print "\n Does the file have headers (y/n): "
  headers = gets.chomp
else
  filename = ARGV.shift
  ARGV.empty? ? headers = "n" : headers = ARGV.shift
end

p headers
csv = CSV.read(filename, headers: true)
p csv.headers
p csv