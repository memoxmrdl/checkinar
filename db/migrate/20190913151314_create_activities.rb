class CreateActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :activities do |t|
      t.string :name, null: false
      t.string :description
      t.string :occurs_on
      t.text :occurs_frequency, array: true
      t.date :occurs_at
      t.time :start_at
      t.integer :duration
      t.boolean :active, default: true
      t.decimal :latitude
      t.decimal :longitude
      t.decimal :radius
      t.belongs_to :organization, index: true
      t.timestamps
    end
  end
end
