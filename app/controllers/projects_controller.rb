class ProjectsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @project = Project.new(owner: current_user)
  end

  def create
    @project = Project.new(project_params)
    @project.owner = current_user

    if @project.save
      flash[:notice] = '您已经成功发布了项目需求。'
      render :show
    else
      render :new
    end
  end

  def show
    @project = current_user.projects.find(params[:id])
  end

  private
  def project_params
    params.require(:project).permit(:category_id, :attachment_id, :name, :budget, :description, :dead_line, :bidding_dead_line)
  end
end