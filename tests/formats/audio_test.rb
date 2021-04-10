require 'minitest/autorun'
require_relative '../../formats/audio'

describe Audio do
  it 'returns a hash with audio details' do
    no_of_audio = 15
    audio_tally = Audio.compute(no_of_audio)

    assert_equal '15 FLAC $1957.5', audio_tally[:total]
    assert_equal '1 x 9 $1147.5', audio_tally[:breakdown][0]
    assert_equal '1 x 6 $810.0', audio_tally[:breakdown][1]

    assert_equal 2, audio_tally.length
  end

  it 'raises an error when no_of_audio is less than Audio::MINIMUM' do
    no_of_audio = 2

    error = assert_raises(RuntimeError) { Audio.compute(no_of_audio) }
    assert_equal 'Insufficient audio quantity', error.message
  end
end
