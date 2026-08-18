class Api::V1::ProjectsController < ApplicationController
  skip_forgery_protection

  def index
    projects = Project.all
    render json: projects
  end

  def show
    project = Project.find_by(id: params[:id])

    if project
      render json: project, status: :ok
    else
      render json: { message: "Project không tồn tại" }, status: :not_found
    end
  end

  def create
    project = Project.new(project_params)

    if project.save
      render json: project, status: :created
    else
      render json: project.errors, status: :unprocessable_entity
    end
  end

  def update
    project = Project.find_by(id: params[:id])

    if project && project.update(project_params)
      render json: project, status: :ok
    else
      render json: { message: "Project không tồn tại hoặc cập nhật thất bại" },
             status: :unprocessable_entity
    end
  end

  def destroy
    project = Project.find_by(id: params[:id])

    if project && project.destroy
      render json: { message: "Đã xoá project" }, status: :ok
    else
      render json: { message: "Project không tồn tại" }, status: :not_found
    end
  end

  private

  def project_params
    params.permit(:name, :description, :owner_id)
  end
end
