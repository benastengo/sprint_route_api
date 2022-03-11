class OrderSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :blend, :volume, :day, :fulfilled, :preferred_window

  belongs_to :customer
  belongs_to :user
end
