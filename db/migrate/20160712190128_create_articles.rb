class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.belongs_to :user, index:true
      t.belongs_to :article_request,  default: -1
      t.string :heading
      t.string :intro
      t.string :content
      t.text :topics,         default: []

      t.timestamps null: false
    end

    create_table :article_requests do |t|
      t.belongs_to :user, index:true
      t.text :topics
      t.string :heading
      t.string :explanation

      t.timestamps null: false
    end
  end
end
