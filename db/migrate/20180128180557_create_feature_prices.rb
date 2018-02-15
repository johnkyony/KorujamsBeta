class CreateFeaturePrices < ActiveRecord::Migration
  def change
    create_table :feature_prices do |t|
      t.string :service_feature_name
      t.float :amount

      t.timestamps null: false
    end
  end
end
