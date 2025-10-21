class CreateTaggings < ActiveRecord::Migration[5.2]
  def change
    create_table :taggings do |t|
      t.references :tag, foreign_key: true, null: false
      t.references :question, foreign_key: true, null: false

      t.timestamps
    end

    add_index :taggings, [:tag_id, :question_id], unique: true
  end
end
