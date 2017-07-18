class CreateHistoryTranslation < ActiveRecord::Migration[5.0]
  def change
    create_table :history_translations do |t|
      t.string :text_from
      t.string :text_to
      t.string :lang_from
      t.string :lang_to
      t.integer :user_id
      t.timestamps
    end
  end
end
