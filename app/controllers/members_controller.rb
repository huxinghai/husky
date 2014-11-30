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

  def change_password
    @user = User.find(params[:id])
    respond_to do |format|  
      user = params.require(:user).permit(:password, :password_confirmation, :old_password)
      if @user.valid_password?(user.delete(:old_password))
        if @user.update_attributes(user)
          format.json{ head :no_content }
        else
          format.json{ render json: {messages: @user.errors.full_messages.join(",") }, status: 403 }
        end
      else
        format.json{ render json: {messages: '你的旧密码不正确！'}, status: 403 }
      end
    end
  end

  def change_avatar
    @user = User.find(params[:id])
    respond_to do |format|
      @user.avatars = params[:file]
      if @user.save
        format.json{ render json: {url: @user.avatars.url(:small), success: true } }
      else
        format.json{ render json: {messages: @user.errors.full_messages.join(",") }, status: 403 }
      end
    end
  end

  private
  def update_params
    params.require(:user).permit(:name, :email, :city_id, :province_id, :pages, :github_login)
  end
end