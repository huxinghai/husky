module ApplicationHelper

  def set_navbar_active(name)
    content_for :navbar_active do 
      name.to_s
    end
  end
end
