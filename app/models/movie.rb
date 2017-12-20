class Movie < ApplicationRecord
  #association

  has_many :comments
  has_many :user, through: :comments



  mount_uploader :image, MovieUploader
  validates :title, :genre, :plot, :rating, :web, :image, :presence => true

#search logic
  def self.search(search)
  where("title LIKE ?", "%#{search}%")
end
end
