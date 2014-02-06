ActiveAdmin.register Product do

  
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


  permit_params :name, :price, :description, :category_ids

  
  before_filter :set_product, only: [:show, :edit, :update, :destroy]

  controller do
    def set_product
      @product = Product.find_by_slug(params[:id])
    end
  end


  # member_action :show do
  #   @product = Product.find_by_slug(params[:id])
  # end

  # member_action :edit do
  #   @product = Product.find_by_slug(params[:id])
  # end

  # member_action :update do
  #   @product = Product.find_by_slug(params[:id])
  # end


  index do
    column :name
    column :description
    column "Category", :category_ids do |i|
      Category.find(i.category_ids.last).name
    end
    column :price, :sortable => :price do |product|
      number_to_currency product.price
    end
    default_actions
  end

  form do |f|
    f.inputs "Details", :class => "small_form" do
      f.input :name
      f.input :description
      f.input :price
      f.input :categories, :label => "Category",:as => :select, :multiple => false, :include_blank => false,
                           :collection => f.template.nested_set_options(Category){|i| "#{'-' * i.level} #{i.name}" }
    end

    f.actions
  end


end
