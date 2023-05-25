require 'csv'

# Class to store the details of the doctor
class Doctor
  
  # @return [Sring] doctor_name Name of the doctor
  attr_reader :doctor_name
  
  # @return [String] specialization Specialization of the doctor
  attr_reader :specialization
  
  # @return [Integer] from_time Appointments will be available from given time
  attr_reader :from_time
  
  # @return [Integer] to_time Appointments will be available till given time
  attr_reader :to_time
  
  # @return [Integer] total_slot Slot of doctor available per day
  attr_reader :total_slot
  
  # Initializes
  #
  # @param [Hash] doctor
  # @option doctor [String] :doctor_name Name of the doctor
  # @option doctor [String] :specialization Specialization of the doctor
  # @option doctor [Integer] :available_from Doctor will available from time
  # @option doctor [Integer] :available_till Doctor will available till time
  # @option doctor [Integer] :total_slot Available slot for appointment
  #
  # @return [void]
  def initialize(doctor)
    @doctor_name = doctor[:name]
    @specialization = doctor[:specialization]
    @from_time = doctor[:available_from]
    @to_time = doctor[:available_till]
    @total_slot = doctor[:total_slot]
  end
  
  # Searches doctor by name
  #
  # @param [String] doctor_name name of the doctor
  # @return Doctor
  def self.find_by(doctor_name)
    csv = CSV.open('CSV/doctor.csv', 'r', headers: true)
    csv.find { |row| row['doctor_name'] == doctor_name }
  end
  
  # Searches doctor by specialization
  # 
  # @param [String] specialization Specialization of the doctor
  # @return Doctor
  def self.find_by_specialization(specialization)
    csv = CSV.open('CSV/doctor.csv', 'r', headers: true)
    csv.find { |row| row['specialization'] == specialization }
  end
    
  # adds new doctor
  def save_to_csv
    CSV.open('CSV/doctor.csv', 'a') do |row|
      row << attributes
    end
  end
  
  # @return [Array] Array of attributes
  def attributes
    [doctor_name, specialization, from_time, to_time, total_slot]
  end

end
