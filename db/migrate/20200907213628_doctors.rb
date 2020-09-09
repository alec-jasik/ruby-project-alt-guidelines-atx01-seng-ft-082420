class Doctors < ActiveRecord::Migration[5.2]
  def change
    create_table :doctors do |doc|
      doc.string :name
      doc.string :specialty
      doc.string :location
      doc.integer :yrs_experience
      doc.timestamps
    end
  end
end
