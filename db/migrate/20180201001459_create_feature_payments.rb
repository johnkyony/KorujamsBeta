class CreateFeaturePayments < ActiveRecord::Migration
  def change
    create_table :feature_payments do |t|
      t.references :project_milestone, index: true, foreign_key: true
      t.float :amount
      t.string :transaction_id

      t.timestamps null: false
    end
  end
end
