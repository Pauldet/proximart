class AddRatingsCountToExhibitions < ActiveRecord::Migration[6.0]
  def change
    add_column :exhibitions, :ratings_count, :integer
  end
end
