class Fixdescriptionname < ActiveRecord::Migration[6.0]
  def change
    rename_column :visits, :description, :information
  end
end
