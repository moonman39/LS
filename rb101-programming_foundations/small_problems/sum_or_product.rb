def prompt message
  puts "\n=> #{message}"
end

def get_input message
  print "\n=> #{message}: "
end

def valid_input? input, message
  loop do
    get_input message
    input = gets.chomp
  
    break if (input.to_i.to_s == input && input.to_i.positive?) ||
              (input.downcase == 's' || input.downcase == 'p')
    prompt "Please enter a valid input"
  end

  input
end

loop do
  integer = valid_input?(integer, "Please enter an integer greater than 0").to_i
  user_choice = valid_input?(user_choice, "Enter 's' to compute the sum, 'p' to computer the product")

  sum = (1..integer).reduce(:+)
  product = (1..integer).reduce(:*)

  if user_choice == "s"
    prompt "The sum of the integers between 1 and #{integer} is #{sum}"
  else
    prompt "The product of the integers between 1 and #{integer} is #{product}"
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

prompt "Thank you for your time!"
  