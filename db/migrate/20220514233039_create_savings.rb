class CreateSavings < ActiveRecord::Migration[7.0]
  def change
    create_table :savings do |t|
      t.decimal :value
      t.datetime :date

      t.timestamps
    end
  end
end
