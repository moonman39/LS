# Pre-Video Code

# Initializing Methods and Variables
def integer_check(input)
  conversion = input.to_i
  conversion.to_s == input 
end

def input_to_number(input)
  number = input.to_i
end

valid_operators = ['+', "-", "/", "*", "%"]
converted_number_1 = nil
converted_number_2 = nil
operation = nil


loop do
  # Get Two Number Inputs from User
  loop do
    puts "\nPlease enter your first number:"
    number_1 = gets.chomp
    converted_number_1 = input_to_number(number_1).to_f

    puts "\nPlease enter your second number:"
    number_2 = gets.chomp
    converted_number_2 = input_to_number(number_2)

    # Check if the inputs were valid integers
    break if integer_check(number_1) && integer_check(number_2)

    puts "Invalid input! Make sure you enter two integers"
  end

  # Get Operator Input from User
  loop do
    puts "\nPlease enter your desired operation:"
    operation = gets.chomp

    break operation if valid_operators.include?(operation)

    puts "Invalid input! Please enter +, -, *, /, or %"
  end

  # Perform Operation
  case operation
    when "+"  then puts converted_number_1 + converted_number_2
    when "-"  then puts converted_number_1 - converted_number_2
    when "*"  then puts converted_number_1 * converted_number_2
    when "/"  then puts converted_number_1 / converted_number_2
    when "%"  then puts converted_number_1 % converted_number_2
  end

  break
end




