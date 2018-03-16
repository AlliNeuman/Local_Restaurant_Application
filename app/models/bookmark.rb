class Bookmark < ActiveRecord::Base
  belongs_to :user
  belongs_to :restaurant

  validates_uniqueness_of :user_id, scope: :restaurant_id



end
