class ChangeOccurencesToString < ActiveRecord::Migration[6.0]
  def change
    change_column :exhibitions, :occurences, :string
  end
end
