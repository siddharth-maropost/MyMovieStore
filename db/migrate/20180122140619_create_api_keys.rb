class CreateApiKeys < ActiveRecord::Migration[5.1]
  def change
    create_table :api_keys do |t|
      t.string :access_token
      t.integer :user_id
      t.references :user, index: true
      t.timestamps
    end
  end
end
