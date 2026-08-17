class Api::V1::UsersController < ApplicationController
skip_forgery_protection

  def index
    users = User.all

    render json: users
  end

def show
  user = User.find_by(id: params[:id])

  if user
    render json: user, status: :ok
  else
    render json: { message: "Người dùng không tồn tại" }, status: :not_found
  end
end

  def create
    user = User.new(user_params)

    if user.save
      render json: user, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

 def update
  user = User.find_by(id: params[:id])

  if user && user.update(user_params)
    render json: { message: "Cập nhật thành công" }, status: :ok
  else
    render json: { message: "Người dùng không tồn tại hoặc cập nhật thất bại" }, status: :unprocessable_entity
  end
end

  def destroy
    user = User.find_by(id: params[:id])

    if user.nil?
        render json: { message: "Người dùng không tồn tại" }, status: :not_found
    elsif user.destroy
        render json: { message: "Đã xoá" }, status: :ok
    else
        render json: { message: "Không tìm thấy người dùng" }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
