require 'minitest/autorun'
require_relative '../../formats/video'

describe Video do
  before do
    no_of_video = 13
    @video_tally = Video.compute(no_of_video)
  end

  it 'returns a hash with audio details' do
    assert_equal '13 VID $2370.0', @video_tally[:total]
    assert_equal '2 x 5 $900.0', @video_tally[:breakdown][0]
    assert_equal '1 x 3 $570.0', @video_tally[:breakdown][1]
  end
end
