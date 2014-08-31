class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.belongs_to :user
      t.string :industry
      t.string :job_title
      t.text :bio
      t.string :location
      t.integer :latitude
      t.integer :longitude
      t.timestamps
    end
  end
end
