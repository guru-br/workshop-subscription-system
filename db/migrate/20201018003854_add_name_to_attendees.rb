class AddNameToAttendees < ActiveRecord::Migration[6.0]
  def change
    add_column :attendees, :name, :string
  end
end
