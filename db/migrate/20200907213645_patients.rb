class Patients < ActiveRecord::Migration[5.2]
  def change
    create_table :patients do |pat|
      pat.string :name
      pat.integer :age
      pat.integer :weight
      pat.integer :height
      pat.timestamps
    end
  end
end
