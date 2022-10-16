module ApplicationHelper
  include Pagy::Frontend
  def nav_tab(title, url, options = {})
    current_page = options.delete :current_page

    css_class = current_page == title ? 'text-secondary' : 'text-white'

    options[:class] = if options[:class]
                        options[:class] + ' ' + css_class
                      else
                        css_class
                      end
    
    link_to title, url, options
  end

  def bootstrap_class_for(k) {
     success:"alert-success",
      error:  "alert-danger",
      danger: "alert-danger",
      alert:  "alert-warning",
      notice: "alert-info"
    }
    [k.to_sym] || k
  end

  def nested_dropdown(items)
    result = []
    items.map do |item, sub_items|
        result << [('- ' * item.depth) + item.name, item.id]
        result += nested_dropdown(sub_items) unless sub_items.blank?
    end
    result
  end
end

  