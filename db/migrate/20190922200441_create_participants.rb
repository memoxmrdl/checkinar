class CreateParticipants < ActiveRecord::Migration[6.0]
  def change
    create_table :participants do |t|
      t.belongs_to :user
      t.belongs_to :activity
      t.integer :roles_mask
      t.timestamps
    end
  end
end
