def prompt message
  puts "\n=> #{message}"
end

def get_input message
  print "\n=> #{message}: "
end

def valid_input? message
  input = nil

  loop do
    get_input message
    input = gets.chomp
  
    break if (input.to_i.to_s == input && input.to_i.positive?)
    prompt "Please enter a valid input"
  end

  input.to_i
end

loop do
  numbers_array = []
  
  numbers_array << valid_input?("Enter the 1st number")
  numbers_array << valid_input?("Enter the 2nd number")
  numbers_array << valid_input?("Enter the 3rd number")
  numbers_array << valid_input?("Enter the 4th number")
  numbers_array << valid_input?("Enter the 5th number")
  last_number =  valid_input?("Enter the last number")

  if numbers_array.include?(last_number)
    prompt "The number #{last_number} appears in #{numbers_array}"
  else
    prompt "The number #{last_number} does not appear in #{numbers_array}"
  end

  another_one = true
  loop do
    get_input "Do you want to enter another calculation? (y / n)"
    valid_inputs = %w(y n)
    response = gets.chomp.downcase
    another_one = false if valid_inputs[1] == response

    break if valid_inputs.include?(response)
    prompt "Please select a valid choice"
  end

  break if another_one == false
end