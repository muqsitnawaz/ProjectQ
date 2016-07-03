class CreateContests < ActiveRecord::Migration
  def change
    create_table :contests do |t|
      t.belongs_to :user, index:true
      t.integer :prize,       null: false
      t.string :status,       default: 'open'
      t.string :content,      null: false
      t.string :detail,       null: false
      t.string :image
      t.text :topics,         default: []
      t.date :end_date
      t.boolean :winner_chosen, default: false
      t.integer :winner_id

      t.timestamps null: false
    end

    create_table :contest_answers do |t|
      t.belongs_to :contest, index:true
      t.belongs_to :user, index:true
      t.string :answer,              null: false
      t.string :image
      t.boolean :is_winner,      default: false

      t.timestamps null: false
    end
  end
end
