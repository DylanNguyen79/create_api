class Api::V1::AuthController < ApplicationController
  def signup
    user = User.new(user_params)

    if user.save
    SendWelcomeEmailJob.perform_later(user.id)


      render json: { message: "Bạn đã đăng ký thành công" }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: user.id)

      render json: { token: token }, status: :ok
    else
      render json: { error: "Email hoặc mật khẩu không đúng" }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
