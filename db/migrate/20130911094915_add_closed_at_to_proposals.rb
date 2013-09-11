class AddClosedAtToProposals < ActiveRecord::Migration
  def change
    add_column :proposals, :closed_at, :datetime
  end
end
