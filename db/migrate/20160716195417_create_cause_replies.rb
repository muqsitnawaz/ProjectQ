class CreateCauseReplies < ActiveRecord::Migration
  def change
    create_table :cause_replies do |t|
      t.belongs_to :cause_comment, index:true
      t.belongs_to :user, index:true
      t.string :reply,               null: false
      
      t.timestamps null: false
    end
  end
end
