class CreateTask < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.references :project, index: true, foreign_key: true
      t.string :title
      t.text :description
      t.integer :day
      t.integer :parent_task_id, default: nil
      t.timestamps
    end
  end
end
