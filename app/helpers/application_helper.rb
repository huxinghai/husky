module ApplicationHelper

  def set_navbar_active(name)
    content_for :navbar_active do 
      name.to_s
    end
  end

  def form_error_messages(obj)
    content_tag :div, class: 'error_messag' do 
      obj.errors.full_messages.map do |err| 
        content_tag :div, err, class: "alert alert-danger msg-error"
      end.join('').html_safe
    end if obj.errors.present?
  end
end
