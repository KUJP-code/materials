class CreateClasses < ActiveRecord::Migration[7.1]
  def change
    create_table :classes do |t|
      t.string :name
      t.references :school, null: false, foreign_key: true

      t.timestamps
    end
  end
end