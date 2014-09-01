class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.belongs_to :user
      t.string :industry
      t.string :job_title
      t.text :bio
      t.string :location
      t.decimal :latitude
      t.decimal :longitude
      t.timestamps
    end
  end
end
