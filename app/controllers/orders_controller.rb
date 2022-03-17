class OrdersController < ApplicationController
  before_action :authenticate_user, only: [:index]
  def index
    if current_user.manager
      orders = Order.all
      render json: orders
    end
  end

  def create
    if (current_user && current_user.manager) || Customer.find(params[:customer_id])
      order = Order.new(
        customer_id: params[:customer_id],
        blend: params[:blend],
        volume: params[:volume],
        day: params[:day],
        fulfilled: false,
        preferred_window: params[:preferred_window]
      )
      if order.save
        render json: order, status: :created
      else
        render json: { errors: order.errors.full_messages }, status: :bad_request
      end
    end
  end

  def update
    order = Order.find(params[:id])
    if (current_user && current_user.manager) || order.customer_id == params[:customer_id]
      order.blend = params[:blend] || order.blend
      order.volume = params[:volume] || order.volume
      order.day = params[:day] || order.day
      order.fulfilled = params[:fulfilled] || order.fulfilled
      order.preferred_window = params[:preferred_window] || order.preferred_window
      if order.save
        render json: order, status: 200
      else
        render json: { errors: order.errors.full_messages }, status: :bad_request
      end
    else
      render json: {}, status: :unauthorized
    end

  end

  def destroy
    order = Order.find(params[:id])
    if (current_user && current_user.manager) || order.customer_id == params[:customer_id].to_i
      order.destroy
      render json: { message: "Order Destroyed"}
    else
      render json: {}, status: :unauthorized
    end
  end
end
