module ApplicationHelper
  def clear(subclass=nil, options = {})
    subclass = ' ' + subclass unless subclass.blank?
    styles = []
    styles << "height:#{options[:height]}px" unless options[:height].blank?

    options[:styles].each{|prop, val| styles << "#{prop}:#{val}"} if options[:styles]
    styles_str = styles.empty? ? '' : " style=\"#{styles.join('; ')}\""
    "<div class=\"clear#{subclass}\"#{styles_str}></div>".html_safe
  end

  def write_flash(*attrs)
    res = (attrs.blank? ? [ :fail, :warn, :success, :notice] : attrs).collect do |item|
      text = flash[item].to_s.split("\n").collect { |text| h text }.join("<br />\n") if flash[item]
      %[<div class="alert alert-#{item}">#{text}</div>] if text
    end.compact.join
    res.html_safe
  end

  def nav_tabs(tabs = {})
    res = tabs.collect do |tab|
      content_tag :li, :class => request.fullpath.split(/[\??]/)[0] == tab[1] ? 'active' : '' do
        link_to tab[0], tab[1]
      end
    end

    content_tag :ul, :class => "nav navbar-nav" do
      res.join.html_safe
    end
  end
end
