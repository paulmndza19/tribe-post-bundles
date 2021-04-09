module Video
  BUNDLE_PRICES = {
    3 => 570.00,
    5 => 900.00,
    9 => 1530.00
  }

  MINIMUM = 3

  def self.compute(no_of_video)
    valid?(no_of_video)

    total = 0
    price_breakdown = []
    video_left = no_of_video

    bundle_keys = BUNDLE_PRICES.keys.sort.reverse

    bundle_keys.each do |bundle_key|
      next if bundle_key > video_left

      remainder = video_left%bundle_key

      # check if remainder can still be bundled or if the remainder is the sum of any 2 available bundles
      can_still_be_bundled = bundle_keys.include?(remainder) || (bundle_keys - [bundle_key]).sum == remainder
      # also check if there is no remaining VID
      no_available_video = remainder == 0

      if can_still_be_bundled || no_available_video
        number_of_bundles_in_quantity = video_left/bundle_key

        price = number_of_bundles_in_quantity * BUNDLE_PRICES[bundle_key]

        total+=price

        price_breakdown << "#{number_of_bundles_in_quantity} x #{bundle_key} $#{BUNDLE_PRICES[bundle_key]}"

        video_left = remainder
      end
    end

    breakdown(no_of_video, total, price_breakdown)
  end

  private

  def self.valid?(no_of_video)
    if no_of_video < MINIMUM
      STDERR.puts "Insufficient video quantity"
    end
  end

  def self.breakdown(no_of_video, total, price_breakdown)
    {
      total: "#{no_of_video} VID $#{total}",
      breakdown: price_breakdown
    }
  end
end
