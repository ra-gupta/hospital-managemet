class Student

  # @return [String] student_name Name of the Student
  attr_reader :student_name

  # @return [Integer] standard Standard to which student belongs to
  attr_reader :standard

  # @return [Integer] roll_no Roll number of the student
  attr_reader :roll_no

  # @return [Integer] age Age of the student
  attr_reader :age

  
  # Initializes
  #
  # @param [Array] details
  # @option student [String] name Name of the student
  # @option student [Integer] age Age of the student
  # @option student [Integer] roll_no Roll number of the student
  # @option student [Integer] age Age of the student
  #
  # @return [void]
  def initialize(details)
    @student_name = details[0]
    @standard = details[1]
    @roll_no = details[2]
    @age = details[3]
  end
  
  def display
    puts " Name : #{student_name}
      Standard: #{standard}
      Roll number :#{roll_no}
      Age : #{age}"
  end

end

student = ["Rahul", 12, 56, 20]
new_student = Student.new(student)
new_student.display

