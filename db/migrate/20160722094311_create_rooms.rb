class CreateRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :rooms do |t|
      t.string :name
      t.float :dimension_x
      t.float :dimension_y

      t.timestamps
    end
  end
end
