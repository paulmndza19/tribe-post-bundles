require 'minitest/autorun'
require_relative '../../formats/images'

describe Images do
  before do
    no_of_images = 10
    @image_tally = Images.compute(no_of_images)
  end

  it 'returns a hash with audio details' do
    assert_equal '10 IMG $800.0', @image_tally[:total]
    assert_equal '1 x 10 $800.0', @image_tally[:breakdown][0]

    assert_equal 1, @image_tally[:breakdown].length
  end
end
