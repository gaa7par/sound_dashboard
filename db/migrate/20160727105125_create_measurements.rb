class CreateMeasurements < ActiveRecord::Migration[5.0]
  def change
    create_table :measurements do |t|
      t.integer :measure
      t.datetime :time
      t.references :recorder, foreign_key: true

      t.timestamps
    end
  end
end
