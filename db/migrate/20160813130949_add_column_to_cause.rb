class AddColumnToCause < ActiveRecord::Migration
  def change
     add_column :causes, :petition, :boolean
      add_column :causes, :pledge, :boolean
  end
end
