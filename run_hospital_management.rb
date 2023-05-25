require 'tty-prompt'
require_relative 'appointment'
require_relative 'doctor'
require_relative 'patient'
require_relative 'enquiry_desk'


prompt = TTY::Prompt.new

# Add's new doctor to the system
def add_doctor(prompt)
  doctor = {}
  doctor[:name] = prompt.ask('Enter the name of the doctor')
  doctor[:specialization] = prompt.ask('Enter the specialization of the doctor')
  doctor[:available_from] = prompt.ask('Enter the time available from', convert: :int)
  doctor[:available_till] = prompt.ask('Enter the time till the doctor will be available', convert: :int)
  doctor[:total_slot] = (doctor[:available_till] / 100 - doctor[:available_from] / 100)
  new_doctor = Doctor.new(doctor)
  if new_doctor.save_to_csv
    puts "Details of #{doctor[:name]} have been added to the system"
  else
    puts "Details not saved, try again"
  end
end

# Add's new patient to the system
def add_patient(prompt)
  patient = {}
  patient[:name] = prompt.ask('Enter the name of the patient ')
  patient[:age] = prompt.ask('Enter the age of the patient')
  patient[:contact_number] = prompt.ask('Enter the contact number of the patient')
  new_patient = Patient.new(patient)
  new_patient.save_to_csv
end

# Book's appointment of doctor and the patient
def book_appointment(prompt)
  doctor_name = prompt.ask('Enter Doctor Name').to_s
  patient_name = prompt.ask('Enter the name of the patient').to_s
  doctor = Doctor.find_by(doctor_name)
  patient = Patient.find_by(patient_name)
  if Appointment.booked_slots(doctor) < doctor['total_slot'].to_i
    if Appointment.book(doctor, patient)
      puts "Appointment has been booked #{doctor_name} and #{patient_name}"
    end
  else
    puts 'Slot is not available today, Please visit Next Day'
  end
end

# Check's for avaiability of doctor
def doctor_availability(prompt)
  doctor_name = prompt.ask('Enter the name of the doctor')
  doctor = Doctor.find_by(doctor_name)
  if Appointment.booked_slots(doctor) == doctor['total_slot'].to_i
    puts "#{doctor_name}'s today appintment's have been booked, visit tomorrow"
  else
    puts "Dr. #{doctor_name}  is available today"
  end
end

# Search's doctor by name
def search_doctor(prompt)
  doctor_name = prompt.ask('Enter the name of the doctor')
  doctor = Doctor.find_by(doctor_name)
  puts "#{doctor}"
end

# List appointments of the doctor
def doctor_appointment(prompt)
  doctor_name = prompt.ask('Enter the name of the doctor')
  appointment = Appointment.new
  puts "#{appointment.doctor_appointments(doctor_name)}"
end

# List appointment's of the patient
def patient_appointment(prompt)
  patient_name = prompt.ask('Enter the name of the patient')
  appointment = Appointment.new
  puts "#{appointment.patient_appointments(patient_name)}"
end

# Menu
loop do
  choice = prompt.select('Please select your option:',EnquiryDesk.menu)
  case choice
  when 1
    add_doctor(prompt)
  when 2
    add_patient(prompt)
  when 3
    book_appointment(prompt)
  when 4
    doctor_availability(prompt)
  when 5
    search_doctor(prompt)
  when 6
    doctor_appointment(prompt)
  when 7
    patient_appointment(prompt)
  end
  break if choice == 8
end
