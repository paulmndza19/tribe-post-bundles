module Images
  BUNDLE_PRICES = {
    5 => 450.00,
    10 => 800.00
  }

  MINIMUM = 5
  MAXIMUM = 10

  # since individual price is not indicated in the pdf, I divided 450 by 5 which is the minimum quantity for a bundle
  INDIVIDUAL_PRICE = 90

  def self.compute(no_of_images)
    valid?(no_of_images)

    total = 0
    price_breakdown = []
    images_left = no_of_images

    while images_left > 0
      if images_left >= MAXIMUM
        number_bundles_in_quantity = images_left/MAXIMUM
        price = number_bundles_in_quantity * BUNDLE_PRICES[MAXIMUM]
        total+=price
        price_breakdown << "#{number_bundles_in_quantity} x #{MAXIMUM} $#{BUNDLE_PRICES[MAXIMUM]}"
        images_left = images_left%MAXIMUM
      elsif images_left >= MINIMUM && images_left < MAXIMUM
        number_bundles_in_quantity = images_left/MINIMUM
        price = number_bundles_in_quantity * BUNDLE_PRICES[MINIMUM]
        total+=price
        price_breakdown << "#{number_bundles_in_quantity} x #{MINIMUM} $#{BUNDLE_PRICES[MINIMUM]}"
        images_left = images_left%MINIMUM
      elsif images_left < MINIMUM
        price = individual_pricing(images_left)
        price_breakdown << "#{images_left} x 1 $#{INDIVIDUAL_PRICE}"
        total+=price
        images_left = 0
      end
    end

    breakdown(no_of_images, total, price_breakdown)
  end

  private

  def self.valid?(no_of_images)
    if no_of_images < MINIMUM
      STDERR.puts "Insufficient number of images"
    end
  end

  def self.individual_pricing(no_of_images)
    no_of_images * INDIVIDUAL_PRICE
  end

  def self.breakdown(no_of_images, total, price_breakdown)
    {
      total: "#{no_of_images} IMG $#{total}",
      breakdown: price_breakdown
    }
  end
end
