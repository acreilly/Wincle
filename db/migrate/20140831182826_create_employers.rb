class CreateEmployers < ActiveRecord::Migration
  def change
    create_table :employers do |t|
      t.string :first_name
      t.string :last_name
      t.integer :telephone
      t.string :email
      t.string :password_digest
      t.string :company
      t.string :industry
      t.timestamps
    end
  end
end
