module ApplicationHelper
  def t_model(path)
    t("activerecord.attributes.#{path}")
  end
end
