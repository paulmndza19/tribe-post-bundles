
#!/usr/bin/env ruby

require_relative 'submission'

def valid_format?(input)
  return false if input == ''

  if /^\d+ IMG$/ =~ input || /^\d+ VID$/ =~ input || /^\d+ FLAC$/ =~ input
    return true
  else
    STDERR.puts "#{input} is an invalid format" unless /^\d+ IMG$/ =~ input || /^\d+ VID$/ =~ input || /^\d+ Flac$/ =~ input
    return false
  end
end

def print_tally(submission_formats)
  submission = Submission.new(submission_formats)
  puts submission.process_tally
end

def get_submissions
  submission_formats = []

  input = ' '
  while input != ''
    input = gets.chomp
    submission_formats << input if valid_format?(input)
  end

  submission_formats
end

if $0 == __FILE__
  msg = "Enter your submissions. Press Enter on a blank line when you're done"
  puts msg

  submission_formats = get_submissions
  print_tally(submission_formats)
end

