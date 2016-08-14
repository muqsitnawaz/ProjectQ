class AddTotalpledgesToCause < ActiveRecord::Migration
  def change
    add_column :causes, :total_pledges, :integer
    add_column :causes, :total_signs, :integer
  end
end
