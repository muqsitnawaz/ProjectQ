class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :content
      t.string :image
      t.string :detail
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
