class AddAverageRatingToExhibitions < ActiveRecord::Migration[6.0]
  def change
    add_column :exhibitions, :average_rating, :float
  end
end
