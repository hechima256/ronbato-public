class AddForeignKeyToTopic < ActiveRecord::Migration[7.0]
    def change
        change_column :topics, :title, :string, null: false
        change_column :topics, :description, :text, null: false
        remove_column :topics, :state, :string
        change_column :topics, :image, :string, default: "0.jpg", null: false
        change_column :topics, :view, :integer, default: 0, null: false
        add_reference :topics, :owner, foreign_key: { to_table: :users }
    end
end
