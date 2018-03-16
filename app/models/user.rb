class User < ActiveRecord::Base
  has_many :created_restaurants, class_name: "Restaurant"
  has_many :bookmarks
  has_many :restaurants, through: :bookmarks

  has_secure_password

  validates_uniqueness_of :username


  validates :username, length: { minimum: 3 }
  validates :password, length: { in: 6..20 }


end
