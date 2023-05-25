require 'csv'

# Class to Book Appointment and manage appointment's
class Appointment
  
  # Book's new appointment
  #
  # @param [CSV::row] doctor Details of the doctor
  # @param [CSV::row] patient Details of the patient
  # @return [void]
  #
  def self.book(doctor, patient)
    array = []
    current_date = Time.now.strftime('%d/%m/%Y')
    booked_slot = booked_slots(doctor)
    array << current_date
    array << doctor['doctor_name']
    array << patient ['patient_name']
    slot_from = doctor['from_time'].to_i + booked_slot * 100
    array << slot_from
    slot_to = slot_from + 100
    array << slot_to
    CSV.open('CSV/appointment.csv', 'a') do |row|
      row << array
    end
  end
  
  # Check's the booked slots of the doctor
  #
  # @param [CSV::row] doctor Details of the doctor
  # @return [Integer] count Count of booked slot's
  def self.booked_slots(doctor)
    current_date = Time.now.strftime('%d/%m/%Y')
    count = 0
    appointments = CSV.read('CSV/appointment.csv')
    appointments.each do |appointment|
      count += 1 if appointment[1] == doctor['doctor_name'].to_s && appointment[0].to_s == current_date
    end
    count
  end
  
  # Searches doctor's appointment
  # 
  # @param [String] doctor_name Name of the doctor
  # @return doctor's appointments
  def doctor_appointments(doctor_name)
    appointments = CSV.read('CSV/appointment.csv', headers: true)
    appointment = appointments.select { |row| row['doctor_name'] == doctor_name }
  end
  
  # Searches patient's appointment
  #
  # @param [String] patient_name Name of the patient
  # @return patient's appointments
  def patient_appointments(patient_name)
    appointments = CSV.read('CSV/appointment.csv', headers: true)
    appointment = appointments.select { |row| row['patient_name'] == patient_name }
  end

end
