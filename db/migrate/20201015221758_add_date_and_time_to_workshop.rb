class AddDateAndTimeToWorkshop < ActiveRecord::Migration[6.0]
  def change
    add_column :workshops, :workshop_date, :date
    add_column :workshops, :start_time, :time
  end
end
