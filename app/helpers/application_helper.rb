module ApplicationHelper
  def t_model(path)
    t("activerecord.attributes.#{path}")
  end

  def price_unit(price)
    "#{number_with_delimiter(price)}円"
  end
end
