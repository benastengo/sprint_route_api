class UsersController < ApplicationController
  before_action :authenticate_user

  def index
    if current_user.manager
      users = User.all
      render json: users
    end
  end

  def show
    user = User.find(params[:id])
    render json: user, include: ["orders.customer"]
  end

  def create
    user = User.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      tractor_number: params[:tractor_number],
      trailer_number: params[:trailer_number],
      manager: params[:manager],
      location: params[:location],
      email: params[:email],
      password: params[:password],
      password_confirmation: params[:password_confirmation]
    )
    if user.save
      render json: { message: "User created successfully" }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end

  def update
    user = User.find(params[:id])
    user.first_name = params[:first_name] || user.first_name
    user.last_name = params[:last_name] || user.last_name
    user.tractor_number = params[:tractor_number] || user.tractor_number
    user.trailer_number = params[:trailer_number] || user.trailer_number
    user.location = params[:location] || user.location
    user.email = params[:email] || user.email
    render json: user
  end

  def destroy
    user = User.find(params[:id])
    user.delete
    render json: { message: "User destroyed successfully"}
  end
end
