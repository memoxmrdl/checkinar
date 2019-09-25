class AddSlackChannelToActivity < ActiveRecord::Migration[6.0]
  def change
    add_column :activities, :slack_channel, :string
  end
end
