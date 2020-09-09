class AppointmentNote < ActiveRecord::Migration[5.2]
  def change
    create_table :appointment_notes do |n|
      n.belongs_to :appointment
      n.string :note
      n.string :doctor_reccomendation
    end
  end
end
