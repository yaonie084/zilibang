class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :title
      t.text :description
      t.integer :longtime
      t.string :tel
      t.string :state
      t.boolean :over, :default => false
      t.boolean :finish, :deault => false
      t.integer :low_price
      t.integer :high_price
      t.references :user
      t.boolean :paid, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
