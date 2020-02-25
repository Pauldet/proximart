class CreateSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :subscriptions do |t|
      t.boolean :subscribed
      t.references :users, null: false, foreign_key: true
      t.references :visits, null: false, foreign_key: true

      t.timestamps
    end
  end
end
