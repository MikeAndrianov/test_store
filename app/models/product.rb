class Product < ActiveRecord::Base
  # include Tire::Model::Search
  # include Tire::Model::Callbacks

  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  validates :name, :price, :presence => true
  validates :name, :uniqueness => true
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}

  # def self.search(params)
  #   tire.search(load: true) do
  #     query { string params[:query], default_operator: "AND" } if params[:query].present?
  #     filter :range, published_at: {lte: Time.zone.now}
  #   end
  # end

end
