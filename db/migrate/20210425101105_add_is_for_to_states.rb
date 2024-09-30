class AddIsForToStates < ActiveRecord::Migration[6.1]
  def change
    add_column :states, :isfor, :integer
  end
end
