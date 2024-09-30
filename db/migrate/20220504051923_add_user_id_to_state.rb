class AddUserIdToState < ActiveRecord::Migration[7.0]
    def change
        add_reference :states, :owner, foreign_key: { to_table: :users }
    end
end
