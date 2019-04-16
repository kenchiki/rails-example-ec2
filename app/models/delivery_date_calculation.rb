# frozen_string_literal: true

class DeliveryDateCalculation
  DATE_MIN = 3
  DATE_MAX = 14
  LOOP_MAX = 100

  def calc_dates
    current_date = Time.current.to_date
    dates = []
    date_count = 0
    LOOP_MAX.times do
      break if dates.size >= (DATE_MAX - DATE_MIN)
      dates << current_date if date_addable?(current_date, date_count)
      current_date = current_date.tomorrow
      date_count += 1 if date_count < DATE_MIN
    end
    dates
  end

  def dates
    @dates ||= calc_dates
  end

  def include?(date)
    dates.include?(date)
  end

  private

  def date_addable?(current_date, date_count)
    return false if current_date.sunday? || current_date.saturday? || date_count < DATE_MIN

    true
  end
end
