class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.integer :points
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
