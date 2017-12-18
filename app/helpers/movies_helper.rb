module MoviesHelper
  def isactive_rating?(view)
    if view == "by_rating"
      return "active"
    end
  end

  def isactive_views?(view)
    if view == "by_views"
      return "active"
    end
  end
end
