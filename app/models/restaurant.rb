class Restaurant < ActiveRecord::Base
  belongs_to :creator, class_name: "User", foreign_key: "user_id", optional: true
  has_many :bookmarks
  has_many :users, through: :bookmarks

  validates_presence_of :name, message: "Restaurant name missing."
  validates_presence_of :category, message: "Restaurant category missing."
  validates_presence_of :tips, message: "Restaurant tips missing."
  validates_presence_of :street_address, message: "Restaurant street address missing."
  validates_presence_of :neighborhood, message: "Restaurant neighborhood missing."

  def bookmark_saved_restaurant(user_id, visited)
    @bookmark = Bookmark.new(visited: visited)
    @bookmark.restaurant_id = self.id
    @bookmark.user_id = self.user_id
    @bookmark.save
  end

  def remove_creator_assocation_and_bookmark
    @bookmark = Bookmark.find_by(restaurant_id: self.id)
    @bookmark.destroy
    self.creator = nil
    self.save
  end

  def visited_restaurant?
    @restaurants = Restaurant.all
    if @restaurant.visited?


end
