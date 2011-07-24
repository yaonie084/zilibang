class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :title
      t.text :description
      t.integer :longtime
      t.string :tel
      t.string :state
      t.boolean :over
      t.integer :low_price
      t.integer :high_price
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
