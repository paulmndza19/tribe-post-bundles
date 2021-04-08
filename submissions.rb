require_relative "formats/images"
require_relative "formats/audio"
require_relative "formats/video"

module Submissions
  def self.process
    submission = []

    msg = "Enter your submissions"
    puts msg

    input = ' '
    while input != ''
      input = gets.chomp
      submission << input if valid_format?(input)
    end

    images_tally = {}
    audio_tally = {}
    video_tally = {}

    submission.each do |submission|
      if submission.include? 'IMG'
        images = submission.split(' ')
        no_of_images = images.first.to_i
        images_tally = Images.compute(no_of_images)
      elsif submission.include? 'Flac'
        audio = submission.split(' ')
        no_of_audio = audio.first.to_i
        audio_tally = Audio.compute(no_of_audio)
      elsif submission.include? 'VID'
        video = submission.split(' ')
        no_of_video = video.first.to_i
        video_tally = Video.compute(no_of_video)
      end
    end

    print_results(images_tally, audio_tally, video_tally)
  end

  private

  def self.print_results(images_tally, audio_tally, video_tally)
    print_tally images_tally
    print_tally audio_tally
    print_tally video_tally
  end

  def self.print_tally(tally)
    return if tally.empty?

    puts "#{tally[:total]}\n"
    # puts tally[:breakdown].join('\n')
    tally[:breakdown].each do |details|
      puts "\t#{details}\n"
    end
  end

  def self.valid_format?(input)
    return false if input == ''

    if /^\d+ IMG$/ =~ input || /^\d+ VID$/ =~ input || /^\d+ Flac$/ =~ input
      return true
    else
      STDERR.puts "#{input} is an invalid format" unless /^\d+ IMG$/ =~ input || /^\d+ VID$/ =~ input || /^\d+ Flac$/ =~ input
      return false
    end
  end
end


Submissions.process