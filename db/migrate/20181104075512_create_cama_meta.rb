class CreateCamaMeta < ActiveRecord::Migration[5.2]
  def change
    create_table :cama_meta do |t|
      t.string :object_class
      t.integer :objectid

      t.timestamps
    end
  end
end
