class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :tractor_number, :trailer_number, :manager, :location, :email
end
