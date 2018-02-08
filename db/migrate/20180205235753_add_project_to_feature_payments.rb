class AddProjectToFeaturePayments < ActiveRecord::Migration
  def change
    add_reference :feature_payments, :project, index: true, foreign_key: true
  end
end
