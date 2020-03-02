class AddFullAddressToExhibitions < ActiveRecord::Migration[6.0]
  def change
    add_column :exhibitions, :full_address, :string
  end
end
