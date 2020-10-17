class AddStatusToWorkshops < ActiveRecord::Migration[6.0]
  def change
    add_column :workshops, :status, :integer, default: 0
  end
end
