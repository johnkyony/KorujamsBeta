class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :repo_id
      t.string :repo_name
      t.string :repo_description
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
