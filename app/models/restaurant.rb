class Restaurant < ActiveRecord::Base
  belongs_to :creator, class_name: "User", foreign_key: "user_id", optional: true
  has_many :bookmarks
  has_many :users, through: :bookmarks

end
