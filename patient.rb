require 'csv'

class Patient
  
  # @return [String] patient_name Name of the patient
  attr_reader :patient_name
  
  # @return [Integer] age Age of the patient
  attr_reader :age
  
  # @return [Integer] contact_number Contact number of the patient
  attr_reader :contact_number
  
  # @return [Integer] uid Registeration id of the patient
  attr_reader :uid
  
  # Initializes
  #
  # @param [Hash] patient
  # @option patient [String] :name Name of the patient
  # @option patient [Integer] :age Age of the patient
  # @option patient [Integer] :contact_number Contact number of the patient
  #
  # @return [void]
  def initialize(patient)
    @patient_name = patient[:name]
    @age = patient[:age]
    @contact_number = patient[:contact_number]
    @uid = Time.now.to_i
  end
  
  # Searches the patient by name
  # 
  # @param [String] patient_name Name of the patient
  # @return patient
  def self.find_by(patient_name)
    csv = CSV.open('CSV/patient.csv', 'r', headers: true)
    csv.find { |row| row['patient_name'] == patient_name }
  end
  
  # Save's the attributes to the csv file
  def save_to_csv
    CSV.open('CSV/patient.csv','a') do |row|
      row << attributes
    end
  end
  
  # create's an array of attributes
  #
  # @return [Array] Array of attributes
  def attributes
    [uid, patient_name, age, contact_number]
  end
  
end
