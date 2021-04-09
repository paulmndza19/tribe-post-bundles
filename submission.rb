require_relative "formats/images"
require_relative "formats/audio"
require_relative "formats/video"

class Submission
  def initialize(submission_formats)
    @submission_formats = submission_formats
    @tally = ""
  end

  def process_tally
    images_tally = {}
    audio_tally = {}
    video_tally = {}

    @submission_formats.each do |format|
      if format.include? 'IMG'
        images = format.split(' ')
        no_of_images = images.first.to_i
        images_tally = Images.compute(no_of_images)
      elsif format.include? 'FLAC'
        audio = format.split(' ')
        no_of_audio = audio.first.to_i
        audio_tally = Audio.compute(no_of_audio)
      elsif format.include? 'VID'
        video = format.split(' ')
        no_of_video = video.first.to_i
        video_tally = Video.compute(no_of_video)
      end
    end

    build_tally(images_tally)
    build_tally(audio_tally)
    build_tally(video_tally)

    @tally
  end

  private

  def print_results(images_tally, audio_tally, video_tally)
    print_tally images_tally
    print_tally audio_tally
    print_tally video_tally
  end

  def build_tally(tally_json)
    return if tally_json.empty?

    @tally+="#{tally_json[:total]}\n"

    tally_json[:breakdown].each do |details|
      @tally+="\t#{details}\n"
    end
  end
end
