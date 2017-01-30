class CreateTwitterUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :twitter_users do |t|
      t.string :provider
      t.string :twuid
      t.string :name
      t.string :token
      t.string :secret
      t.string :profile_image

      t.timestamps
    end
  end
end
