class CreateChores < ActiveRecord::Migration[5.0]
  def change
    create_table :chores do |t|
      t.integer :child_id
      t.integer :task_id
      t.date :due_on
      t.boolean :completed, default: false

      t.timestamps
    end
  end
end
