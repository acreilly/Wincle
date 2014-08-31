class CreateEmployers < ActiveRecord::Migration
  def change
    create_table :employers do |t|
      t.belongs_to :user
      t.string :company
      t.string :industry
      t.timestamps
    end
  end
end
