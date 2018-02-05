class CreateDepositPaids < ActiveRecord::Migration
  def change
    create_table :deposit_paids do |t|
      t.references :project, index: true, foreign_key: true
      t.float :amount
      t.string :transaction_id

      t.timestamps null: false
    end
  end
end
