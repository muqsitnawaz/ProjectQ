class AddHowhelpToCause < ActiveRecord::Migration
  def change
    add_column :causes, :howhelp, :string
  end
end
