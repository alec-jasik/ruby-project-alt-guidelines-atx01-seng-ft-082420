class Appointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |app|
      app.belongs_to :doctor
      app.belongs_to :patient
      app.datetime :appointment_date
      app.datetime :appointment_time
      app.string :appointment_location
      app.timestamps
    end
  end
end
