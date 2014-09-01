class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.belongs_to :employer
      t.decimal :wage
      t.string :job_title
      t.date :start_date
      t.date :end_date
      t.time :start_time
      t.time :end_time
      t.text :description
      t.string :location
      t.decimal :latitude
      t.decimal :longitude
      t.boolean :expiration_status, default: false
      t.timestamps
    end
  end
end
