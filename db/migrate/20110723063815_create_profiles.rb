class CreateProfiles < ActiveRecord::Migration
  def self.up
    create_table :profiles do |t|
      t.string :title
      t.string :name
      t.boolean :male
      t.string :school
      t.integer :graduation
      t.string :tel
      t.string :plan
      t.text :description
      t.string :avatar_file_name
      t.string :avatar_content_type
      t.integer :avatar_file_size
      t.references :user

    end
  end

  def self.down
    drop_table :profiles
  end
end
