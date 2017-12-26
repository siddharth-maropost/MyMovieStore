class Movie < ApplicationRecord
  #association

  has_many :comments, dependent: :destroy
  has_many :user, through: :comments



  mount_uploader :image, MovieUploader
  validates :title, :genre, :plot, :rating, :web, :image, :presence => true
  validates :rating, numericality: { less_than_or_equal_to: 10 }
#search logic
  def self.search(search)
    where("title LIKE ?", "%#{search}%")
  end
end
