class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.integer :category_type, default: 0, null: false

      t.timestamps
    end
  end
end
