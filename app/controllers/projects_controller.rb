class ProjectsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create]

  def index
    @projects = Project.order("created_at desc").page(params[:page])
  end

  def new
    @project = Project.new(owner: current_user)
  end

  def create
    binding.pry
    @project = Project.new(project_params)
    @project.owner = current_user
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
    @attachment.user = current_user
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
    params.require(:project).permit(:category_id, :name, :budget, :budget_state, :description, :price_type, attachment_ids: [], budget_list: ProjectBudget.kind_all)
  end
end