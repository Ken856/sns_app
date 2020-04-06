module Search
  def search(search, column)
    if search
      where("#{column} LIKE ?", "%#{search}%")
    else
      self.none
    end
  end
end
