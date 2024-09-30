class AddColumnToStateRelations < ActiveRecord::Migration[7.0]
    def change
        add_column :state_relations, :generation, :integer, null: false, default: 0
    end
end
