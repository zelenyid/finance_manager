class CreateRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :records do |t|
      t.decimal :amount, :precision => 8, :scale => 2
      t.references :category, index: true, foreign_key: true
      t.references :account, index: true, foreign_key: true

      t.timestamps
    end
  end
end
