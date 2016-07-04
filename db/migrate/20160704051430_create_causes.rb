class CreateCauses < ActiveRecord::Migration
  def change
    create_table :causes do |t|
      t.belongs_to :user, index:true
      t.string :cause_type
      t.string :intro
      t.string :detail
      t.string :whymatters
      t.string :image

      t.timestamps null: false
    end

    create_table :cause_comments do |t|
      t.belongs_to :user, index:true
      t.belongs_to :cause, index:true
      t.string :comment

      t.timestamps null: false
    end
  end
end
