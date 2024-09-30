class CreateStateRelations < ActiveRecord::Migration[7.0]
    def change
        create_table :state_relations do |t|
            t.belongs_to :ancestor, foreign_key: { to_table: :states}, null: false
            t.belongs_to :descendant, foreign_key: { to_table: :states}, null:false
            t.timestamps
        end
    end
end
