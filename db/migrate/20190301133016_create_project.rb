class CreateProject < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.jsonb :workingdays, default: []
      t.timestamps
    end
  end
end
