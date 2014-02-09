class Category < ActiveRecord::Base
  acts_as_nested_set

  extend FriendlyId
  friendly_id :name, :use => :slugged

  validates :name, :presence => true
  validates :name, :uniqueness => true

  has_many :categorizations, :dependent => :destroy
  has_many :products, :through => :categorizations


  # %w[camera ram os].each do |key|
  #   scope "has_#{key}", lambda { |value| where("additional_fields @> (? => ?)", key, value) }
    
  #   define_method(key) do
  #     additional_fields && additional_fields[key]
  #   end
    
  #   define_method("#{key}=") do |value|
  #     self.additional_fields = (additional_fields || {}).merge(key => value)
  #   end
  # end

end
