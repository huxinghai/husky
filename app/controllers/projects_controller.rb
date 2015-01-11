class ProjectsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create]

  def index
    @projects = Project.page(params[:page])
  end

  def new
    @project = Project.new(owner: current_user)
  end

  def create
    @project = Project.new(project_params)
    @project.owner = current_user
    tag_ids = (params[:project][:tag_ids] || []).delete_if { |id| id.blank? }
    tag_ids.each { |id| @project.tags << Tag.find(id) }

    respond_to do |format|
      if @project.save
        flash[:notice] = '您已经成功发布了项目需求。'
        format.html{ redirect_to project_path(@project) }
      else
        format.html{ render :new }
      end
    end
  end

  def show
    @project = Project.find(params[:id])
  end

  def upload
    @attachment = Attachment.new_project
    @attachment.file = params[:file]
    respond_to do |format|
      if @attachment.save
        format.json{ render json: @attachment }
      else
        format.json{ render json: {messages: @attachment.errors.full_messages}, status: 403 }
      end
    end
  end

  private
  def project_params
    params.require(:project).permit(:category_id, :attachment_id, :name, :budget, :description, :dead_line, :bidding_dead_line, :tag_ids)
  end
end