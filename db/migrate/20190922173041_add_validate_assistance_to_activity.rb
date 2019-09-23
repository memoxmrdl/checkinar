class AddValidateAssistanceToActivity < ActiveRecord::Migration[6.0]
  def change
    add_column :activities, :validate_attendance, :boolean, null: false, default: false
  end
end
