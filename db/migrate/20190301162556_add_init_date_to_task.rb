class AddInitDateToTask < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :init_date, :date, default: nil
    add_column :tasks, :finish_date, :date, default: nil
  end
end
