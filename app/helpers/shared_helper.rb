module SharedHelper
  def render_to_info(info, image, default_image, name, link)
    render "shared/info", info: info, image: image, default_image: default_image, name: name, link: link
  end
end
