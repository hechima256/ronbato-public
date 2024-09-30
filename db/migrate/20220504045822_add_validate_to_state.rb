class AddValidateToState < ActiveRecord::Migration[7.0]
    def change
        change_column :states, :content, :text, null: false
        change_column :states, :position, :integer, null: false, default: 0
        change_column :states, :view, :integer, null: false, default: 0
        change_column_null :states, :topic_id, false
    end
end
