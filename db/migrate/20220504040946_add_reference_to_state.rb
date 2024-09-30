class AddReferenceToState < ActiveRecord::Migration[7.0]
    def change
        change_column :states, :content, :text
        rename_column :states, :isfor, :position
        add_column :states, :view, :integer
        # add_foreign_key :states, :topics
		add_reference :states, :topic, foreign_key: true
    end
end
