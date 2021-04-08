module Video
  BUNDLE_PRICES = {
    3 => 570.00,
    6 => 900.00,
    9 => 1530.00
  }

  # since individual price is not indicated in the pdf, I divided 570 by 3 which is the minimum quantity for a bundle
  INDIVIDUAL_PRICE = 190

  def self.compute(no_of_video)
    valid?(no_of_video)

    total = 0
    price_breakdown = []
    video_left = no_of_video

    while video_left > 0
      if video_left >= 9
        number_bundles_in_quantity = video_left/9
        price = number_bundles_in_quantity * BUNDLE_PRICES[9]
        total+=price
        price_breakdown << "#{number_bundles_in_quantity} x 9 $#{BUNDLE_PRICES[9]}"
        video_left = video_left%9
      elsif video_left >= 6 && video_left < 9
        number_bundles_in_quantity = video_left/6
        price = number_bundles_in_quantity * BUNDLE_PRICES[6]
        total+=price
        price_breakdown << "#{number_bundles_in_quantity} x 6 $#{BUNDLE_PRICES[6]}"
        video_left = video_left%6
      elsif video_left >= 3 && video_left < 6
        number_bundles_in_quantity = video_left/3
        price = number_bundles_in_quantity * BUNDLE_PRICES[3]
        total+=price
        price_breakdown << "#{number_bundles_in_quantity} x 3 $#{BUNDLE_PRICES[3]}"
        video_left = video_left%3
      elsif video_left < 3
        price = individual_pricing(video_left)
        price_breakdown << "#{video_left} x 1 $#{INDIVIDUAL_PRICE}"
        total+=price
        video_left = 0
      end
    end

    breakdown(no_of_video, total, price_breakdown)
  end

  private

  def self.valid?(no_of_video)
    if no_of_video < 3
      STDERR.puts "Insufficient video quantity"
    end
  end

  def self.individual_pricing(no_of_video)
    no_of_video * INDIVIDUAL_PRICE
  end

  def self.breakdown(no_of_video, total, price_breakdown)
    {
      total: "#{no_of_video} VID $#{total}",
      breakdown: price_breakdown
    }
  end
end
