class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.belongs_to :user, index:true
      t.string :content
      t.string :image
      t.string :detail
      t.text :topics,	default: []

      t.timestamps null: false
    end

    create_table :answers do |t|
      t.belongs_to :question, index:true
      t.belongs_to :user, index:true
      t.string :answer
      t.string :image
      t.integer :upvotes,     default: 0
      t.integer :downvotes,   default: 0

      t.timestamps null: false
    end
  end
end
