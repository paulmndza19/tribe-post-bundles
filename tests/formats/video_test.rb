require 'minitest/autorun'
require_relative '../../formats/video'

describe Video do
  it 'returns a hash with audio details' do
    no_of_video = 13
    video_tally = Video.compute(no_of_video)

    assert_equal '13 VID $2370.0', video_tally[:total]
    assert_equal '2 x 5 $900.0', video_tally[:breakdown][0]
    assert_equal '1 x 3 $570.0', video_tally[:breakdown][1]

    assert_equal 2, video_tally.length
  end

  it 'raises an error when no_of_video is less than Video::MINIMUM' do
    no_of_video = 2

    error = assert_raises(RuntimeError) { Video.compute(no_of_video) }
    assert_equal 'Insufficient video quantity', error.message
  end
end
