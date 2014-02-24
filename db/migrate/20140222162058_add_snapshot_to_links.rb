class AddSnapshotToLinks < ActiveRecord::Migration
  def change
    add_column :links, :snapshot, :string
  end
end
