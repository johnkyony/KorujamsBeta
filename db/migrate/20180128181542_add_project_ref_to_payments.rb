class AddProjectRefToPayments < ActiveRecord::Migration
  def change
    add_reference :payments, :project, index: true, foreign_key: true
  end
end
