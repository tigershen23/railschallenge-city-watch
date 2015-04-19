class CreateResponders < ActiveRecord::Migration
  def change
    create_table :responders do |t|
      t.string :name
      t.integer :capacity
      t.string :type
      t.boolean :on_duty, null: false, default: false
      t.boolean :available
      t.string :emergency_code

      t.timestamps null: false
    end

    add_index :responders, :emergency_code
    add_index :responders, :type
  end
end
