class CreateAttendances < ActiveRecord::Migration[6.0]
  def change
    create_table :attendances do |t|
      t.belongs_to :activity, index: true
      t.belongs_to :user, index: true
      t.datetime :attended_at, null: false
      t.string :status, null: false, default: "pending"
      t.decimal :latitude
      t.decimal :longitude
      t.timestamps
    end
  end
end
