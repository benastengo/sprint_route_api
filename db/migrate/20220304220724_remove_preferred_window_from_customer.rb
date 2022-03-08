class RemovePreferredWindowFromCustomer < ActiveRecord::Migration[7.0]
  def change
    remove_column :customers, :preferred_window, :string
  end
end
