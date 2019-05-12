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
    add_business_dates([])
  end

  def business_date?(date)
    if date.sunday? || date.saturday?
      return false
    end

    true
  end

  def next_business_date(date)
    tomorrow = date.tomorrow
    if business_date?(tomorrow)
      tomorrow
    else
      next_business_date(tomorrow)
    end
  end

  def add_business_dates(dates)
    if dates.length < DATE_MAX
      date = dates.length == 0 ? Time.current.to_date.yesterday : dates.last
      add_business_dates(dates << next_business_date(date))
    else
      dates.slice((DATE_MIN - 1)..DATE_MAX)
    end
  end
end
