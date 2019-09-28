class AddInvitedAtToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :invited_at, :datetime
  end
end
