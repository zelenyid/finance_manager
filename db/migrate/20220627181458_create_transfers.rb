class CreateTransfers < ActiveRecord::Migration[7.0]
  def change
    create_table :transfers do |t|
      t.references :receiver, index: true, foreign_key: { to_table: :accounts }
      t.references :sender, index: true, foreign_key: { to_table: :accounts }
      t.decimal :amount, :precision => 8, :scale => 2

      t.timestamps
    end
  end
end
