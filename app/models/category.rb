class Category < ActiveRecord::Base
  acts_as_nested_set

  validates :name, :presence => true
  validates :name, :uniqueness => true

  has_many :categorizations, :dependent => :destroy
  has_many :products, :through => :categorizations

end
