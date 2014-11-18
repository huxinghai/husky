class TeamsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @teams = current_user.teams
  end

  # TODO: will finish in next pr
  def invite_member

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
end
