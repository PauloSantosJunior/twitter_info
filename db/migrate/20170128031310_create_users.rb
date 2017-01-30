class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.string :postal_code
      t.string :street_name
      t.string :city_name
      t.string :state_name
      t.string :country_name
      t.string :telephone
      t.string :email

      t.timestamps
    end
  end
end
