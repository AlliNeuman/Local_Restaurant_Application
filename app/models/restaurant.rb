class Restaurant < ActiveRecord::Base
  belongs_to :creator, class_name: "User", foreign_key: "user_id", optional: true
  has_many :bookmarks
  has_many :users, through: :bookmarks


  def bookmark_saved_restaurant(user_id, visited)
    @bookmark = Bookmark.new(user_id: user_id, visited: visited)
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


end
