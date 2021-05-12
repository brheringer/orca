class CreateEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :entries do |t|
      t.date :date
      t.decimal :expected_value
      t.decimal :actual_value
      t.text :memo
      t.references :account
      t.string :username

      t.timestamps
    end
    add_index :entries, :username
  end
end
