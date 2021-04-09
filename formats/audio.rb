module Audio
  BUNDLE_PRICES = {
    3 => 427.50,
    6 => 810.00,
    9 => 1147.50
  }

  MINIMUM = 3

  def self.compute(no_of_audio)
    valid?(no_of_audio)

    total = 0
    price_breakdown = []
    audio_left = no_of_audio

    bundle_keys = BUNDLE_PRICES.keys.sort.reverse

    bundle_keys.each do |bundle_key|
      next if bundle_key > audio_left

      remainder = audio_left % bundle_key

      # check if remainder can still be bundled or if the remainder is the sum of any 2 available bundles
      can_still_be_bundled = bundle_keys.include?(remainder) || (bundle_keys - [bundle_key]).sum == remainder
      # also check if there is no remaining FLAC
      no_available_audio = remainder == 0

      if can_still_be_bundled || no_available_audio
        number_of_bundles_in_quantity = audio_left/bundle_key

        price = number_of_bundles_in_quantity * BUNDLE_PRICES[bundle_key]

        total+=price

        price_breakdown << "#{number_of_bundles_in_quantity} x #{bundle_key} $#{BUNDLE_PRICES[bundle_key]}"

        audio_left = remainder
      end
    end

    breakdown(no_of_audio, total, price_breakdown)
  end

  private

  def self.valid?(no_of_audio)
    if no_of_audio < MINIMUM
      STDERR.puts "Insufficient audio quantity"
    end
  end

  def self.breakdown(no_of_audio, total, price_breakdown)
    {
      total: "#{no_of_audio} FLAC $#{total}",
      breakdown: price_breakdown
    }
  end
end
