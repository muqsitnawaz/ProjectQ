class AddColumnsToCause < ActiveRecord::Migration
  def change
    add_column :causes, :petitionTo, :string
  end
end
