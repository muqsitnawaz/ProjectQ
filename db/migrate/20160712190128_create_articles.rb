class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.belongs_to :user, index:true
      t.string :heading
      t.string :intro
      t.string :content
      t.text :topics,         default: []

      t.timestamps null: false
    end
  end
end
