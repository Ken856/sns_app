module Search
  def search(search, column)
    if search
      where("#{column} LIKE ?", "%#{search}%")
    else
      none
    end
  end
end
