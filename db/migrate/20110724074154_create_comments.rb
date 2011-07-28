class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.text :content
      t.references :user
      t.references :post
      t.integer :price
      t.string  :code
      t.boolean :verified, :default => false
      t.boolean :buyer_sure, :default => false
      t.boolean :employer_sure, :default => false
      t.text :buyer_content
      t.integer :buyer_level, :default => 0
      t.text :employer_content
      t.integer :employer_level, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
