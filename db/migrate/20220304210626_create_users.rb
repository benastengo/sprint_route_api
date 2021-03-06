class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.integer :tractor_number
      t.integer :trailer_number
      t.boolean :manager
      t.string :location
      t.string :email

      t.timestamps
    end
  end
end
