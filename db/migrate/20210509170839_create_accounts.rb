class CreateAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :accounts do |t|
      t.string :structure
      t.string :name
      t.integer :kind
      t.string :username

      t.timestamps
    end
    add_index :accounts, :username
  end
end
