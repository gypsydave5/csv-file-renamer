class Csv_file

  require 'fileutils'

  def initialize(file_name, header=y)
    @file_name = file_name
    @csv_contents = File.readlines(file_name)
    if header == "y"
      header = @csv_contents.shift.split(",")
      header.last.chomp.map!.with_index {|heading, position| [heading, position]}
      @header = Hash[*header.flatten]
    else
      @header = nil
    end

  end

end