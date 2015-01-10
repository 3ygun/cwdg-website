class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def show
  end

  def edit
  end

  def create
    project = Project.new(project_params)
    success = project.save

    if success
      redirect_to project
    else
      render :new, notice: 'Could not create project'
    end
  end

  def update
    success = @project.update(project_params)

    if success
      redirect_to @project
    else
      render :edit, notice: 'Could not update project'
    end
  end

  def destroy
    @project.destroy

    redirect_to projects_path
  end

  private

  def project_params
    params.require(:project).permit(:title, :leader_id, :description, users: [])
  end

  def set_project
    @project = Project.find(params[:id])
  end

end
