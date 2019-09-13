class CreateUsersAndActivities < ActiveRecord::Migration[6.0]
  def change
    create_table :activities_users, id: false do |t|
      t.belongs_to :user, index: true
      t.belongs_to :activity, index: true
    end

    add_index :activities_users, [:user_id, :activity_id], unique: true
  end
end
