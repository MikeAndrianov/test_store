class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :set_category, only: [:index, :show, :new, :edit]
  before_action :set_obj_with_additional_fields, only: [:new, :create]

  # GET /products
  # GET /products.json
  def index
    @products = Product.with_category(params[:category])
                       .simple_search(params[:query])
                       .paginate(:page => params[:page], :per_page => 10)
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
    @categorization = @product.categorizations.build

    respond_to do |format|
      format.html
      format.js { render :template => "/products/edit", :locals => { :selected_category => Category.find(params[:category]) } }
    end
  end

  # GET /products/1/edit
  def edit
    @categorization = Categorization.find_all_by_product_id_and_category_id(@product.id, @product.category.id)

    @obj_with_additional_fields = params[:category] ? Category.find(params[:category]) : @product

    respond_to do |format|
      format.html
      format.js { render :template => "/products/edit", :locals => { :selected_category => Category.find(params[:category]) } }
    end
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render action: 'show', status: :created, location: @product }
      else
        format.html { render action: 'new' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find_by_slug(params[:id])
    end

    def set_category
      @category = Category.find_by_slug(params[:category])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      #params.require(:product).permit(:name, :price, :description)
      params.require(:product).permit!
    end

    def set_obj_with_additional_fields
      @obj_with_additional_fields = params[:category] ? Category.find(params[:category]) : Category.first
    end
end
