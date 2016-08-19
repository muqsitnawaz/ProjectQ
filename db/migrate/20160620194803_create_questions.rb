class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.belongs_to :user, index:true
      t.string :content,      null: false
      t.string :detail,       null: false
      t.boolean :anonymous,   default: false
      t.integer :views,       default: 0
      t.text :topics,	        default: []
      t.text :followers,      default: []

      t.timestamps null: false
    end

    create_table :answers do |t|
      t.belongs_to :question, index:true
      t.belongs_to :user, index:true
      t.string :content,              null: false
      t.boolean :anonymous,   default: false
      t.integer :upvotes,     default: 0
      t.integer :downvotes,   default: 0

      t.timestamps null: false
    end

    create_table :replies do |t|
      t.belongs_to :answer, index:true
      t.belongs_to :user, index:true
      t.string :content,               null: false
      t.boolean :anonymous,   default: false

      t.timestamps null: false
    end
  end
end
