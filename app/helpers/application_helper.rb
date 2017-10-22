module ApplicationHelper
  def hidden_div_if(condition, attributes = {}, &block)
    if condition
      attributes["style"] = "display: none"
    end
    content_tag("div", attributes, &block)
  end

  def if_user_admin(true_or_false_condition, html_tag, block, attributes = {})
    if current_user
      if current_user.admin == true_or_false_condition
        content_tag(html_tag, block, attributes)
      end
    end
  end
end
