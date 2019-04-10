class AppendTextInput < SimpleForm::Inputs::StringInput
  def input(wrapper_options = nil)
    if options[:append]
      return template.content_tag(:div, class: 'input-group') do
        template.concat super(wrapper_options)
        template.concat content_tag(:span, options[:append], class: 'input-group-text')
      end
    end
    super(wrapper_options)
  end
end
