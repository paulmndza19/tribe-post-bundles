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

      addends = bundle_keys - [bundle_key]
      sum_of_any_two_bundle_option = addends.sum
      sum_of_bundle_keys = bundle_keys.sum

      if (video_left % sum_of_any_two_bundle_option).zero?
        return build_breakdown(addends, no_of_video, sum_of_any_two_bundle_option)
        break
      end

      if (video_left % sum_of_bundle_keys).zero?
        return build_breakdown(bundle_keys, no_of_video, sum_of_bundle_keys)
        break
      end

      number_of_bundles_in_quantity = video_left/bundle_key
      price = number_of_bundles_in_quantity * BUNDLE_PRICES[bundle_key]
      total+=price
      price_breakdown << "#{number_of_bundles_in_quantity} x #{bundle_key} $#{BUNDLE_PRICES[bundle_key]}"
      video_left = remainder
    end

    breakdown(no_of_video, total, price_breakdown)
  end

  private

  def self.build_breakdown(addends, no_of_video, divisor)
    total = 0
    price_breakdown = []
    quotient = no_of_video/divisor

    addends.each do |addend|
      price = quotient * BUNDLE_PRICES[addend]
      total+=price
      price_breakdown << "#{quotient} x #{addend} $#{BUNDLE_PRICES[addend]}"
    end

    breakdown(no_of_video, total, price_breakdown)
  end

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

  def self.divisible_by_3_or_5(number)
    digits = number.to_s.chars.map(&:to_i)
    (digits.sum % 3).zero? || (number % 5).zero?
  end
end
