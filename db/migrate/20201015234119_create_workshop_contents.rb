class CreateWorkshopContents < ActiveRecord::Migration[6.0]
  def change
    create_table :workshop_contents do |t|
      t.references :workshop, null: false, foreign_key: true
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
