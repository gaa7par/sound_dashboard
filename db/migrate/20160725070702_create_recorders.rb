class CreateRecorders < ActiveRecord::Migration[5.0]
  def change
    create_table :recorders do |t|
      t.string :name
      t.float :position_x
      t.float :position_y
      t.references :room, foreign_key: true

      t.timestamps
    end
  end
end
