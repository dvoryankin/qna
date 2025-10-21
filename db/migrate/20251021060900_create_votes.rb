class CreateVotes < ActiveRecord::Migration[5.2]
  def change
    create_table :votes do |t|
      t.references :votable, polymorphic: true, null: false
      t.references :user, foreign_key: true, null: false
      t.integer :value, null: false

      t.timestamps
    end

    add_index :votes, [:votable_type, :votable_id, :user_id], unique: true
  end
end
