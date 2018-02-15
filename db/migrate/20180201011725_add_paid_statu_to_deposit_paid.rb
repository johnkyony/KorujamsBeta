class AddPaidStatuToDepositPaid < ActiveRecord::Migration
  def change
    add_column :deposit_paids, :paid_status, :boolean
  end
end
