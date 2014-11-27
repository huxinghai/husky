class TeamsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @teams = current_user.teams.includes(:users)
  end

  def invite_member
    @team = Team.find(params[:id])
    @user = User.find_by_email(params[:invite][:email])
    invitation = @team.invitations.build(invite_params)
    if invitation.save
      render :text => "邀请成功"
    else
      render :text => "邀请失败", :status => 500
    end
  end

  def new
    @team = Team.new(owner: current_user)
  end

  def create
    @team = current_user.teams.build(team_params)

    if @team.save
      flash[:notice] = '您已经成功创建了一个团队，赶紧去竞标吧！'
      render :show
    else
      render :new
    end
  end

  def show
    @team = current_user.teams.find(params[:id])
  end

  private
  def team_params
    params.require(:team).permit(:name, :description)
  end

  def invite_params
    params.require(:invite).merge(from_user_id: current_user.id, to_user_id: @user.try(:id))
          .permit(:description, :email, :to_user_id, :from_user_id)
  end
end
