require 'minitest/autorun'

require_relative 'helpers/io_test_helper'
require_relative '../process_submission'

describe 'get_submissions' do
  before do
    @out, @err = capture_io do
      IoTestHelper.simulate_stdin('10 IMG', '15 FLAC', '13 VID', '19 MP3', '') {
        @submission_formats = get_submissions
      }
    end
  end

  it 'should return an array' do
    assert_equal @submission_formats.class, Array
    assert @submission_formats.include? '10 IMG'
    assert @submission_formats.include? '15 FLAC'
    assert @submission_formats.include? '13 VID'

    refute @submission_formats.include? ''
    refute @submission_formats.include? '19 MP3'
  end
end

describe 'print tally' do
  before do
    submission_formats = ['10 IMG', '15 FLAC', '13 VID', '']
    @out, @err = capture_io do
      print_tally(submission_formats)
    end
  end

  it 'should print a tally of the submission' do
    assert @out.include? '10 IMG $800.0'
    assert @out.include? '1 x 10 $800.0'
    assert @out.include? '15 FLAC $1957.5'
    assert @out.include? '1 x 9 $1147.5'
    assert @out.include? '1 x 6 $810.0'
    assert @out.include? '13 VID $2370.0'
    assert @out.include? '2 x 5 $900.0'
    assert @out.include? '1 x 3 $570.0'
  end
end

describe 'valid_format?' do
  it 'returns false when input is an empty string' do
    input = ''
    refute valid_format?(input)
  end

  it 'returns true when input is an invalid format' do
    image = '10 JPEG'
    refute valid_format?(image)

    audio = '19 MP3'
    refute valid_format?(audio)
  end

  it 'returns true when input is a valid format' do
    image = '10 IMG'
    assert valid_format?(image)

    audio = '15 FLAC'
    assert valid_format?(audio)

    video = '13 VID'
    assert valid_format?(video)
  end
end
