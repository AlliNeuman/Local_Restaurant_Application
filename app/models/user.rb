class User < ActiveRecord::Base
  has_many :created_restaurants, class_name: "Restaurant"
  has_many :bookmarks
  has_many :restaurants, through: :bookmarks

  has_secure_password

  validates_uniqueness_of :username



  def visited_restaurant
    if current_user.id == creator.id
      self.created_restaurants.where("visited = ?", true).order(:name)
    else
      self.restaurants.where("visited = ?", true).order(:name)
  end

  def wishlist_restaurant
    if current_user.id == creator.id  
      restaurants.where("visited = ?", false).order(:name), self.created_restaurants.where("visited = ?", false).order(:name)
    else
    self.restaurants.where("visited = ?", false).order(:name), self.created_restaurants.where("visited = ?", false).order(:name)
  end



end
