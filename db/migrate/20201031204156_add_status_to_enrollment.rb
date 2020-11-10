class AddStatusToEnrollment < ActiveRecord::Migration[6.0]
  def change
    add_column :enrollments, :status, :integer, default: 0
  end
end
