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

  def assignment
    users = params[:user_ids].map {|user_id| User.find(user_id)}
    # Find all orders that are unfulfilled and unassigned
    orders = Order.where(user_id: nil, fulfilled: false)
    users.each do |user|
      # Find all orders that are still unassigned
      orders = orders.where(user_id: nil)
      # Loop through all orders and get each distance from block user and find the shortest distance
      order = orders.map {|order| {distance: order.customer.distance_from(user), order_id: order.id}}.min_by{|order| order[:distance]}
      # Get the right order based on shortest distance and update it's user_id/assign it
      # TODO: Make a way to know this order should be the last one a user fulfills in a day
      Order.find(order[:order_id]).update(user_id: user.id)
    end
    # Take given number of remaining unassigned orders and divide by given number of users
    orders = orders.where(user_id: nil)
    orders_per_user = orders.count / users.count
    # Assign each user that number of orders from remaining array
    users.each do |user|
      orders.take(orders_per_user).each do |order|
        order.update(user_id: user.id)
      end
    end
    # If any orders are left, assign them to the first user
    if orders.any? 
      orders.update_all(user_id: users.first.id)
    end

    render json: orders
  end
end

# Order.update_all(user_id: nil)
