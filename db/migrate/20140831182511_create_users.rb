class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :linkedin_id
      t.string :facebook_id
      t.string :user_type
      t.string :first_name
      t.string :last_name
      t.string :industry
      t.string :email
      t.timestamps
    end
  end
end
