class CustomersController < ApplicationController
  before_action :authenticate_user
  
  def index
    customers = Customer.all
    render json: customers
  end

  def show
    customer = Customer.find(params[:id])
    render json: customer
  end

  def create
    if current_user.manager == true
      customer = Customer.new(
        name: params[:name],
        address: params[:address]
      )
      if customer.save
        render json: { message: "Customer created successfully" }, status: :created
      else
        render json: { errors: customer.errors.full_messages }, status: :bad_request
      end
    end
  end
end
