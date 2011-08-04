class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.integer :sender_id, :null => false
      t.integer :receiver_id, :null => false
      t.boolean :visited, :default => false
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end
