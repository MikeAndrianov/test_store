class Product < ActiveRecord::Base
  # include Tire::Model::Search
  # include Tire::Model::Callbacks

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  validates :name, :price, :presence => true
  validates :name, :uniqueness => true
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}

  has_many :categorizations, :dependent => :destroy
  has_many :categories, :through => :categorizations

  accepts_nested_attributes_for :categorizations

  scope :with_category, lambda { |category_id| 
    return {} if category_id.blank?

    joins(:categorizations => :category).where('categorizations.category_id = ?', category_id).uniq
  }

  scope :simple_search, lambda { |query|
    return {} if query.blank?

    where('products.name LIKE ? OR price LIKE ? OR description LIKE ?', "%#{query}%", "%#{query}%", "%#{query}%")
  }

end
