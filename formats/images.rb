module Images
  BUNDLE_PRICES = {
    5 => 450.00,
    10 => 800.00
  }

  MINIMUM = 5
  MAXIMUM = 10

  def self.compute(no_of_images)
    valid?(no_of_images)

    total = 0
    price_breakdown = []
    images_left = no_of_images

    bundle_keys = BUNDLE_PRICES.keys.sort.reverse

    bundle_keys.each do |bundle_key|
      next if bundle_key > images_left

      if images_left >= MINIMUM
        number_of_bundles_in_quantity = images_left/bundle_key

        price = number_of_bundles_in_quantity * BUNDLE_PRICES[bundle_key]

        total+=price

        price_breakdown << "#{number_of_bundles_in_quantity} x #{bundle_key} $#{BUNDLE_PRICES[bundle_key]}"

        images_left%=bundle_key
      end
    end

    breakdown(no_of_images, total, price_breakdown)
  end

  private

  def self.valid?(no_of_images)
    if no_of_images < MINIMUM
      raise "Insufficient number of images"
    end
  end

  def self.breakdown(no_of_images, total, price_breakdown)
    {
      total: "#{no_of_images} IMG $#{total}",
      breakdown: price_breakdown
    }
  end
end
