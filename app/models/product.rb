class Product < ActiveRecord::Base
  # include Tire::Model::Search
  # include Tire::Model::Callbacks

  extend FriendlyId
  friendly_id :name, :use => :slugged

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  after_save :assign_product_to_parent_categories

  validates :name, :price, :presence => true
  validates :name, :uniqueness => true
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}

  has_many :categorizations, :dependent => :destroy
  has_many :categories, :through => :categorizations

  accepts_nested_attributes_for :categorizations

  scope :with_category, lambda { |category_slug| 
    return {} if category_slug.blank?

    joins(:categorizations => :category).where('categorizations.category_id = ?', Category.find_by_slug(category_slug).id).uniq
  }

  scope :simple_search, lambda { |query|
    return {} if query.blank?

    where('"products"."name" ~* ? OR "products"."description" ~* ?', query, query)
  }

  # Returns Category's leaf which was assigned to Product
  #
  def category
    categories.order('updated_at DESC').first
  end

  protected

  def assign_product_to_parent_categories
    #Remove all previous categorizations for product except last updated 
    #
    Categorization.delete_all(["product_id = ? AND category_id != ?", id, category.id])

    category.ancestors.each do |parent_category|
      Categorization.find_or_create_by_product_id_and_category_id(id, parent_category.id)
    end
  end

end
