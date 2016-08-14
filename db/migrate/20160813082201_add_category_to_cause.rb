class AddCategoryToCause < ActiveRecord::Migration
  def change
    add_column :causes, :category, :string
  end
end
