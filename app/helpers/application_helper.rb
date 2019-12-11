module ApplicationHelper
  def sidebar_product_active(item_product_id, css_class)
    if @product.present?
      if @product.id.to_i == item_product_id.to_i
        css_class += ' active'
      end
    else
      if item_product_id.nil?
        css_class += ' active'
      end
    end
    return css_class
  end

  def setting_sidebar_active(page, css_class)
    selected_path = '/setting/' + page
    if request.path_info.end_with?(page)
      css_class += ' active'
    elsif request.path_info.start_with?(selected_path)
      css_class += ' active'
    end
    return css_class
  end

  def current_page_setting()
    request.path_info.start_with?("/setting")
    # return true if current_page?(setting_path)
    # return true if current_page?(setting_products_path)
    # return true if current_page?(setting_issue_type_path)
  end

  def no_sidebar()
    return true if current_page?(signin_path)
    return true if current_page?(new_user_path)
  end
  
  def user_image_url()
    if @current_user.image? 
      return @current_user.image.url
    end
      return "default_avatar.png"
    else
  end

  def toggle_active(isActive)
    return isActive ? "active" : ""
  end
end
