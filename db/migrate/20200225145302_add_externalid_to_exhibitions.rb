class AddExternalidToExhibitions < ActiveRecord::Migration[6.0]
  def change
    add_column :exhibitions, :external_id, :integer
  end
end
