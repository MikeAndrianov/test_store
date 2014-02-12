class Category < ActiveRecord::Base
  acts_as_nested_set

  extend FriendlyId
  friendly_id :name, :use => :slugged

  after_save :assign_additional_fields_to_products

  validates :name, :presence => true
  validates :name, :uniqueness => true

  has_many :categorizations, :dependent => :destroy
  has_many :products, :through => :categorizations


  def nested_additional_fields
    fields = {}

    self_and_ancestors.each do |category|
      fields = fields.merge(category.additional_fields) if category.additional_fields
    end

    fields
  end


  protected

  def assign_additional_fields_to_products
    products.each do |product|
      product.additional_fields = {} if product.additional_fields.nil?
      self.additional_fields.each{|key, value| product.additional_fields[key] ||= nil }
      product.save!
    end
  end

end
