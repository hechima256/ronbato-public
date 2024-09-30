class RenameClaimColumnToTopics < ActiveRecord::Migration[6.1]
  def change
    rename_column :topics, :claim, :state
  end
end
