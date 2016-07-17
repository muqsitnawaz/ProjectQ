class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.belongs_to :user,   index:true
      t.integer :poster_id
      t.string :resource_type
      t.integer :notification_type
      t.integer :resource_id
    
      t.timestamps null: false
    end
  end
end