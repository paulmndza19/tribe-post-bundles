
#!/usr/bin/env ruby

require_relative 'submission'

submission_formats = []

msg = "Enter your submissions"
puts msg

def valid_format?(input)
  return false if input == ''

  if /^\d+ IMG$/ =~ input || /^\d+ VID$/ =~ input || /^\d+ FLAC$/ =~ input
    return true
  else
    STDERR.puts "#{input} is an invalid format" unless /^\d+ IMG$/ =~ input || /^\d+ VID$/ =~ input || /^\d+ Flac$/ =~ input
    return false
  end
end

input = ' '
while input != ''
  input = gets.chomp
  submission_formats << input if valid_format?(input)
end

submission = Submission.new(submission_formats)
puts submission.process_tally
