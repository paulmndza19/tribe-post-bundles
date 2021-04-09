require 'minitest/autorun'
require_relative '../submission'

describe Submission do
  before do
    @submission_formats = ['10 IMG', '15 FLAC', '13 VID']
    @submission = Submission.new(@submission_formats)
  end

  it 'returns a tally' do
    tally = @submission.process_tally

    assert tally.include? '10 IMG $800.0'
    assert tally.include? '1 x 10 $800.0'
    assert tally.include? '15 FLAC $1957.5'
    assert tally.include? '1 x 9 $1147.5'
    assert tally.include? '1 x 6 $810.0'
    assert tally.include? '13 VID $2370.0'
    assert tally.include? '2 x 5 $900.0'
    assert tally.include? '1 x 3 $570.0'
  end
end
