class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :Count
      t.references :company

      t.timestamps
    end
    add_index :likes, :company_id
  end
end
