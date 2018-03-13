class Restaurant < ActiveRecord::Base
  belongs_to :creator, class_name: "User", foreign_key: "user_id", optional: true
  has_many :bookmarks
  has_many :users, through: :bookmarks


  def bookmark_saved_restaurant(user_id, visited)
    @bookmark = Bookmark.new(visited: visited)

    @bookmark.restaurant_id = self.id
    @bookmark.user_id = self.user_id
    @bookmark.save
binding.pry

  end
end
