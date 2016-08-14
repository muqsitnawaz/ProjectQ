class AddColumsToCause < ActiveRecord::Migration
  def change
    add_column :causes, :totalpeople, :string
    add_column :causes, :pledgeTo, :string
    add_column :causes, :pledgeStep, :string
    add_column :causes, :pledgeDate, :datetime
    
  end
end
