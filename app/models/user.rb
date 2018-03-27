class User < ActiveRecord::Base
  has_many :created_restaurants, class_name: "Restaurant"
  has_many :bookmarks
  has_many :restaurants, through: :bookmarks

  has_secure_password

  validates_uniqueness_of :username



  def visited_restaurant
    self.restaurants.where("visited= ?", true).order('LOWER(name)')
  end

  def wish_list
    self.restaurants.where("visited = ?", false).order('LOWER(name)')
  end

  def all_created_restaurants
    created_restaurants.order('LOWER(name)')
  end


end
