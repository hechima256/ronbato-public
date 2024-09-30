class AddPathAndTopicIdToStates < ActiveRecord::Migration[6.1]
  def change
    add_column :states, :state_path, :string
    # add_column :states, :topic_id, :integer
  end
end
