class Movie < ApplicationRecord
  validates :title, :genre, :plot, :rating, :web, :presence => true
end
