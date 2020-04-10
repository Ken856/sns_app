module SharedHelper
  def render_to_profile(object, link: object, link_cancel: false)
    render "shared/profile", object: object,  link: link, link_cancel: link_cancel
  end
end
