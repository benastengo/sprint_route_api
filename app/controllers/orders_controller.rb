class OrdersController < ApplicationController
  def index
    orders = Order.all
    render json: orders
  end

  def create
    order = Order.new(
      user_id: params[:user_id],
      customer_id: params[:customer_id],
      blend: params[:blend],
      volume: params[:volume],
      day: params[:day],
      fulfilled: params[:fulfilled],
      preferred_window: params[:preferred_window]
    )
    if order.save
      render json: { message: "order created successfully" }, status: :created
    else
      render json: { errors: order.errors.full_messages }, status: :bad_request
    end
  end
end
