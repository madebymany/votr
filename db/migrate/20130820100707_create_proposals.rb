class CreateProposals < ActiveRecord::Migration
  def change
    create_table :proposals do |t|
      t.string :author
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
