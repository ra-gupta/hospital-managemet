# Equiry desk of the hospital
class EnquiryDesk
  # Menu options
  #
  # @return [Hash]
  def self.menu
    [
      { name: '1. Add Doctor', value: 1 },
      { name: '2. Add Patient', value: 2 },
      { name: '3. Book Appointment', value: 3 },
      { name: '4. Check Availability of Doctor', value: 4 },
      { name: '5. Search Doctor', value: 5 },
      { name: "6. List Doctor's Appoinments", value: 6 },
      { name: "7. List Patient's Appoinments", value: 7 },
      { name: '8. Quit', value: 8 }
    ]
  end
  
end
