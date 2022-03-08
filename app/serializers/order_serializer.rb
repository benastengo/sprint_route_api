class OrderSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :customer_id, :blend, :volume, :day, :fulfilled, :preferred_window
end
