class OrdersController < ApplicationController
  before_action :authenticate_user
  def index
    orders = Order.all
    render json: orders
  end

  def create
    if current_user.manager == true
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

  def update
    if current_user.manager == true
      order = Order.find(params[:id])
      order.user_id = params[:user_id] || order.user_id
      order.customer_id = params[:customer_id] || order.customer_id
      order.blend = params[:blend] || order.blend
      order.volume = params[:volume] || order.volume
      order.day = params[:day] || order.day
      order.fulfilled = params[:fulfilled] || order.fulfilled
      order.preferred_window = params[:preferred_window] || order.preferred_window
      render json: order
    end
  end

  def destroy
    if current_user.manager == true
      order = Order.find(params[:id])
      order.destroy
      render json: { message: "Order Destroyed"}
    end
  end
end
