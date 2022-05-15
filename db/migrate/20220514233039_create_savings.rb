class CreateSavings < ActiveRecord::Migration[7.0]
  def change
    create_table :savings do |t|
      t.decimal :value, null: false
      t.datetime :date, null: false

      t.timestamps
    end
  end
end
