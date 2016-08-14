class AddPetToCause < ActiveRecord::Migration
  def change
    add_column :causes, :pet, :boolean
  end
end
