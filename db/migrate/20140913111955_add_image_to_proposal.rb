class AddImageToProposal < ActiveRecord::Migration
  def change
    add_column :proposals, :image, :string
  end
end
