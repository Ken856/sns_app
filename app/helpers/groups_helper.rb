module GroupsHelper

  def naming
    group_name
  end

  def picture
    image_tag object.image.variant(resize: "50x40").processed
  end

  def default_picture
    image_tag(default_group.png, :size => "35x35")
  end
end
