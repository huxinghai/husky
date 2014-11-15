module MembersHelper


  def render_member_main(&block)
    set_render_partial(&block)
    render "main"
  end

  def set_render_partial(&block)
    content_for(:member_partial, &block)
  end
end