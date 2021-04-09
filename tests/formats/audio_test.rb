require 'minitest/autorun'
require_relative '../../formats/audio'

describe Audio do
  before do
    no_of_audio = 15
    @audio_tally = Audio.compute(no_of_audio)
  end

  it 'returns a hash with audio details' do
    assert_equal '15 FLAC $1957.5', @audio_tally[:total]
    assert_equal '1 x 9 $1147.5', @audio_tally[:breakdown][0]
    assert_equal '1 x 6 $810.0', @audio_tally[:breakdown][1]
  end
end
