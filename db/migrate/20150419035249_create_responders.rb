class CreateResponders < ActiveRecord::Migration
  def change
    create_table :responders do |t|
      t.string :name, null: false
      t.integer :capacity, null: false
      t.string :type, null: false
      t.boolean :on_duty, null: false, default: false
      t.string :emergency_code

      t.timestamps null: false
    end

    add_index :responders, :emergency_code
    add_index :responders, :type
  end
end
