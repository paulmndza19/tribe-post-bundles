module Audio
  BUNDLE_PRICES = {
    3 => 427.50,
    6 => 810.00,
    9 => 1147.50
  }

  # since individual price is not indicated in the pdf, I divided 427.50 by 3 which is the minimum quantity for a bundle
  INDIVIDUAL_PRICE = 142.50

  def self.compute(no_of_audio)
    valid?(no_of_audio)

    total = 0
    price_breakdown = []
    audio_left = no_of_audio

    while audio_left > 0
      if audio_left >= 9
        number_bundles_in_quantity = audio_left/9
        price = number_bundles_in_quantity * BUNDLE_PRICES[9]
        total+=price
        price_breakdown << "#{number_bundles_in_quantity} x 9 $#{BUNDLE_PRICES[9]}"
        audio_left = audio_left%9
      elsif audio_left >= 6 && audio_left < 9
        number_bundles_in_quantity = audio_left/6
        price = number_bundles_in_quantity * BUNDLE_PRICES[6]
        total+=price
        price_breakdown << "#{number_bundles_in_quantity} x 6 $#{BUNDLE_PRICES[6]}"
        audio_left = audio_left%6
      elsif audio_left >= 3 && audio_left < 6
        number_bundles_in_quantity = audio_left/3
        price = number_bundles_in_quantity * BUNDLE_PRICES[3]
        total+=price
        price_breakdown << "#{number_bundles_in_quantity} x 3 $#{BUNDLE_PRICES[3]}"
        audio_left = audio_left%3
      elsif audio_left < 3
        price = individual_pricing(audio_left)
        price_breakdown << "#{audio_left} x 1 $#{INDIVIDUAL_PRICE}"
        total+=price
        audio_left = 0
      end
    end

    breakdown(no_of_audio, total, price_breakdown)
  end

  private

  def self.valid?(no_of_audio)
    if no_of_audio < 3
      STDERR.puts "Insufficient audio quantity"
    end
  end

  def self.individual_pricing(no_of_audio)
    no_of_audio * INDIVIDUAL_PRICE
  end

  def self.breakdown(no_of_audio, total, price_breakdown)
    {
      total: "#{no_of_audio} Flac $#{total}",
      breakdown: price_breakdown
    }
  end
end
