# frozen_string_literal: true

class DeliveryDateCalculation
  DATE_MIN = 3
  DATE_MAX = 14
  LOOP_MAX = 100

  def dates
    @dates ||= calc_dates
  end

  def include?(date)
    dates.include?(date)
  end

  private

  def calc_dates
    current_date = Time.current.to_date
    dates = []
    business_date_count = 0
    LOOP_MAX.times do
      if business_date?(current_date)
        business_date_count += 1
      end

      break if business_date_count > DATE_MAX

      if business_date_count >= DATE_MIN && business_date_count <= DATE_MAX && business_date?(current_date)
        dates << current_date
      end

      current_date = current_date.tomorrow
    end

    dates
  end

  def business_date?(date)
    if date.sunday? || date.saturday?
      return false
    end

    true
  end
end
