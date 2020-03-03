class ChangeOccurencesTypeForExhbitions < ActiveRecord::Migration[6.0]
  def change
    remove_column :exhibitions, :occurences, :date
    add_column :exhibitions, :occurences, :jsonb
  end
end
