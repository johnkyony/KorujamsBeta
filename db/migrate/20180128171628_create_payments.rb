class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :pf_payment_id
      t.string :payment_status
      t.string :item_name
      t.integer :amount_gross
      t.integer :amount_fee
      t.integer :amount_net
      t.integer :merchant_id
      t.integer :project_milestone_id

      t.timestamps null: false
    end
  end
end
