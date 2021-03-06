class CustomersController < ApplicationController
  before_action :authenticate_user
  
  def index
    customers = Customer.all
    render json: customers
  end

  def show
    customer = Customer.find(params[:id])
    render json: customer, orders: [:everything, :but, :customer]
  end

  def create
    if current_user.manager
      customer = Customer.new(
        name: params[:name],
        address: params[:address]
      )
      if customer.save
        render json: customer, status: :created
      else
        render json: { errors: customer.errors.full_messages }, status: :bad_request
      end
    else
      render json: {}, status: :unauthorized
    end
  end
end
