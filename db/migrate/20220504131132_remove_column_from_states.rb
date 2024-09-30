class RemoveColumnFromStates < ActiveRecord::Migration[7.0]
	def change
		remove_column :states, :state_path, :string
	end
end
