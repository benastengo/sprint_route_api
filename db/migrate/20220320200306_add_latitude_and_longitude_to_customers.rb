class AddLatitudeAndLongitudeToCustomers < ActiveRecord::Migration[7.0]
  def change
    add_column :customers, :latitude, :float
    add_column :customers, :longitude, :float
  end
end
