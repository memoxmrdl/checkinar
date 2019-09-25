class AddSlackWebhookUrlToOrganizations < ActiveRecord::Migration[6.0]
  def change
    add_column :organizations, :slack_webhook_url, :string
  end
end
