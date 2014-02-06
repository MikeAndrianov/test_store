class Category < ActiveRecord::Base
  acts_as_nested_set

  extend FriendlyId
  friendly_id :name, :use => :slugged

  validates :name, :presence => true
  validates :name, :uniqueness => true

  has_many :categorizations, :dependent => :destroy
  has_many :products, :through => :categorizations

end
