class Movie < ApplicationRecord
  mount_uploader :image, MovieUploader
  validates :title, :genre, :plot, :rating, :web, :image, :presence => true
end
