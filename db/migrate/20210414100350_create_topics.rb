class CreateTopics < ActiveRecord::Migration[6.1]
  def change
    create_table :topics do |t|
      t.string :title
      t.string :description
      t.string :claim
      t.string :image
      t.integer :view

      t.timestamps
    end
  end
end
