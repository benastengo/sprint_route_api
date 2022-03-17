class OrderSerializer < ActiveModel::Serializer
  attributes :id, :customer, :user_id, :blend, :volume, :day, :fulfilled, :preferred_window

  belongs_to :customer
  belongs_to :user
end
