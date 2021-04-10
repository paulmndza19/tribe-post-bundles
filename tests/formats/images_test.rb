require 'minitest/autorun'
require_relative '../../formats/images'

describe Images do
  it 'returns a hash with audio details' do
    no_of_images = 10
    image_tally = Images.compute(no_of_images)

    assert_equal '10 IMG $800.0', image_tally[:total]
    assert_equal '1 x 10 $800.0', image_tally[:breakdown][0]

    assert_equal 1, image_tally[:breakdown].length
  end

  it 'raises an error when no_of_images is less than Images::MINIMUM' do
    no_of_images = 2

    error = assert_raises(RuntimeError) { Images.compute(no_of_images) }
    assert_equal 'Insufficient number of images', error.message
  end
end
