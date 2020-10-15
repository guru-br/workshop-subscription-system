class CreateWorkshops < ActiveRecord::Migration[6.0]
  def change
    create_table :workshops do |t|
      t.string :name
      t.string :short_description
      t.text :full_description
      t.integer :attendees
      t.integer :duration

      t.timestamps
    end
  end
end
