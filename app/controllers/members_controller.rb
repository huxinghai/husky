class MembersController < ApplicationController
  before_filter :authenticate_user!, only: [:settings, :update]

  def show
  end

  def settings
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(update_params)
    respond_to do |format|
      if @user.save
        format.html{ redirect_to member_path(current_user.login) }
        format.json{ render json: @user }
      else
        format.html{ render action: :settings }
        format.json{ render json: {messages: @user.errors.full_messages}, status: 403 }
      end
    end
  end

  private
  def update_params
    params.require(:user).permit(:name, :email, :city_id, :province_id, :pages, :github_login)
  end
end