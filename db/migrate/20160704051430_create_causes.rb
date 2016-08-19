class CreateCauses < ActiveRecord::Migration
  def change
    create_table :causes do |t|
      t.belongs_to :user, index:true
      t.string :cause_type
      t.string :intro
      t.string :detail
      t.string :whymatters
      t.string :image
      
      t.string :category
      t.string :howhelp
      t.string :totalpeople
      
      t.boolean :pledge
      t.string :pledgeTo
      t.string :pledgeStep
      t.datetime :pledgeDate
      
      t.string :petitionTo
      
      t.boolean :dont_pledge
      t.integer :total_pledges, default: 0
      t.integer :total_signs, default: 0
      
      t.string :petition_help
      t.datetime :petitiondate
      t.integer :petition_signs, default: 0
      
      t.boolean :anonymous,   default: false
      t.text :followers,          default: []
      t.integer :num_agree,       default: 0
      t.integer :num_disagree,    default: 0

      t.timestamps null: false
    end

    create_table :cause_comments do |t|
      t.belongs_to :user, index:true
      t.belongs_to :cause, index:true
      t.string :content,      null: false
      t.boolean :anonymous,   default: false

      t.timestamps null: false
    end
    
    create_table :cause_replies do |t|
      t.belongs_to :cause_comment, index:true
      t.belongs_to :user, index:true
      t.string :content,      null: false
      t.boolean :anonymous,   default: false
      
      t.timestamps null: false
    end
  end
end
