class AddApikeyToOrgnaization < ActiveRecord::Migration[6.0]
  def change
    add_column :organizations, :api_key, :string, null: false
  end
end
