class PatientHistory < ActiveRecord::Migration[5.2]
  def change
    create_table :patient_histories do |ph|
      ph.belongs_to :patient
      ph.string :doctor
      ph.string :treatment
      ph.datetime :treatment_date
      ph.timestamps
    end
  end
end
