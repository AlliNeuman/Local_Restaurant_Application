class User < ActiveRecord::Base
  has_many :created_restaurants, class_name: "Restaurant"
  has_many :bookmarks
  has_many :restaurants, through: :bookmarks

  has_secure_password

  validates_uniqueness_of :username


  def visited_restaurant
    self.restaurants.order("visited='true'", :name)
  end

  def wish_list
    self.restaurants.order("visited='false'", :name)
  end

end
