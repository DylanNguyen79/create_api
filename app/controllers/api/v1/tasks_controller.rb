class Api::V1::TasksController < ApplicationController
    skip_forgery_protection

    def index
        tasks = Task.all
        render json: tasks
    end

    def show
        task = Task.find_by(id: params[:id])

        if task
            render json: task, status: :ok
        else
            render json: { message: "Task không tồn tại" }, status: :not_found
        end
    end

    def create
        task = Task.new(task_params)

        if task.save
            render json: task, status: :created
        else
            render json: task.error, status: :unprocessable_entity
        end
    end

    def update
        task = Task.find_by(id: params[:id])

        if task && task.update(task_params)
            render json: task, status: :ok
        else
            render json: { message: "Task không tồn tại hoặc cập nhật thất bại" }, status: unprocessable_entity
        end
    end

    def destroy
        task = Task.find_by(id: params[:id])

        if task && task.destroy
            render json: { message: "Đã xoá task" }, status: :ok
        else
            render json: { message: "Task không tồn tại" }, status: :not_found
        end
    end

    private

    def task_params
        params.permit(
           :name,
           :description,
           :status,
           :due_date,
           :project_id,
           :user_id
        )
    end
end
