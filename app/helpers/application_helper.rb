# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

def flash_message
  messages = ""
  [:success, :warning, :error].each do |type|
    if flash[type]
      messages += content_tag('div', flash[type], :class => type)
      flash[type] = nil
    end
  end
      messages
end

end
