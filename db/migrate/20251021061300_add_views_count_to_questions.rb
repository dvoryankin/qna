class AddViewsCountToQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :questions, :views_count, :integer, default: 0, null: false
  end
end
