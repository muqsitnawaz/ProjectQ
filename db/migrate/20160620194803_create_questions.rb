class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.belongs_to :user, index:true
      t.string :content,      null: false
      t.string :detail,       null: false
      t.string :image
      t.text :topics,	        default: []
      t.text :followers,      default: []

      t.timestamps null: false
    end

    create_table :contests do |t|
      t.belongs_to :user, index:true
      t.integer :prize,       null: false
      t.string :status,       default: 'open'
      t.string :content,      null: false
      t.string :detail,       null: false
      t.string :image
      t.text :topics,         default: []
      t.date :end_date
      t.integer :winner_id

      t.timestamps null: false
    end

    create_table :answers do |t|
      t.belongs_to :question, index:true
      t.belongs_to :user, index:true
      t.string :answer,              null: false
      t.string :image
      t.integer :upvotes,     default: 0
      t.integer :downvotes,   default: 0

      t.timestamps null: false
    end

    create_table :contest_answers do |t|
      t.belongs_to :contest, index:true
      t.belongs_to :user, index:true
      t.string :answer,              null: false
      t.string :image
      t.boolean :winner

      t.timestamps null: false
    end

    create_table :replies do |t|
      t.belongs_to :answer, index:true
      t.belongs_to :user, index:true
      t.string :reply,               null: false

      t.timestamps null: false
    end

    create_table :notifications do |t|
      t.belongs_to :user, index:true
      t.integer :notification_type
      t.integer :question_id
      t.integer :poster_id

      t.timestamps null: false
    end
  end
end
