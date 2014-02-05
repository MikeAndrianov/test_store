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

  accepts_nested_attributes_for :categorizations #, :allow_destroy => true


 
end
