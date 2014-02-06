module ProductsHelper
  
  def breadcrumbs(category)
    if category
      current_category = content_tag :li, category.name, :class => "active"

      content_tag :ol, :class => "breadcrumb" do
        (category.ancestors.collect do |category|
          content_tag :li do
            link_to category.name, products_path(:category => category.slug)
          end
        end << current_category).join.html_safe
      end
    end
  end

end
