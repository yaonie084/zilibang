class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.text :content
      t.references :user
      t.references :post
      t.integer :price
      t.string  :code
      t.boolean :buyer_sure
      t.boolean :employer_sure

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
