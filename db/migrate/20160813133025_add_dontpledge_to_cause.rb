class AddDontpledgeToCause < ActiveRecord::Migration
  def change
    add_column :causes, :dont_pledge, :boolean
  end
end
