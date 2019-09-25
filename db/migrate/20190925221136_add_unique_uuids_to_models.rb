class AddUniqueUuidsToModels < ActiveRecord::Migration[6.0]
  def change
    enable_extension "pgcrypto"

    add_column :users, :uuid, :uuid, default: "gen_random_uuid()", null: false
    add_column :activities, :uuid, :uuid, default: "gen_random_uuid()", null: false
    add_column :participants, :uuid, :uuid, default: "gen_random_uuid()", null: false
    add_column :attendances, :uuid, :uuid, default: "gen_random_uuid()", null: false

    add_index :users, :uuid, unique: true
    add_index :activities, :uuid, unique: true
    add_index :participants, :uuid, unique: true
    add_index :attendances, :uuid, unique: true
  end
end
