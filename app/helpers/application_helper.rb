module ApplicationHelper
  def sec_nav(name, options = {}, &block)
    if @sec_nav == name
      if options[:class]
        options[:class] += " active"
      else
        options[:class] = "active"
      end
    end
    content = capture(&block)
    content_tag(:li, content, options)
  end

  def main_nav(name, options = {}, &block)
    if @main_nav == name
      if options[:class]
        options[:class] += " active"
      else
        options[:class] = "active"
      end
    end
    content = capture(&block)
    content_tag(:li, content, options)
  end

  def profile_nav(name, options = {}, &block)
    if @profile_nav == name
      if options[:class]
        options[:class] += " selected"
      else
        options[:class] = "selected"
      end
    end
    content = capture(&block)

    content_tag(:li, content, options)
  end
end
