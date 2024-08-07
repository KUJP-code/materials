class CreateFaqTutorials < ActiveRecord::Migration[7.1]
  def change
    create_table :faq_tutorials do |t|
      t.string :question
      t.string :answer
      t.references :tutorial_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
