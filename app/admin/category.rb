ActiveAdmin.register Category do

  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end

  before_filter :set_category, only: [:show, :edit, :update, :destroy]

  controller do
    def set_product
      @category = Category.find_by_slug(params[:id])
    end
  end
  

  permit_params :name, :parent_id

  index do
    column :name
    column :parent_id do |i|
      Category.find(i.parent_id).name if i.parent_id
    end
    default_actions
  end

  form do |f|
    f.inputs "Details", :class => "small_form" do
      f.input :name
      f.input :parent_id, :label => "Parent Category",:as => :select, :collection => f.template.nested_set_options(Category) {|i| "#{'-' * i.level} #{i.name}" }
    end

    f.actions
  end
  
end
