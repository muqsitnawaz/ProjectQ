class AddPetitionToCause < ActiveRecord::Migration
  def change
    add_column :causes, :petition_help, :string
    add_column :causes, :petitiondate, :datetime
    add_column :causes, :petitionhelp, :string
    add_column :causes, :petition_signs, :integer
  end
end
