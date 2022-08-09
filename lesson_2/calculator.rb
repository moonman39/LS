# # Pre-Video Code

require "pry"
# Initializing Methods and Variables
def valid_number?(input)
  input.to_i.to_s == input 
end

def input_to_number(input)
  number = input.to_i
end

valid_operators = ['+', "-", "/", "*", "%"]
number1 = nil
number2 = nil
converted_number1 = nil
converted_number2 = nil
operation = nil
result = nil
again = nil


loop do
  # Get Two Number Inputs from User
  loop do
    puts "\nPlease enter your first number:"
    number1 = gets.chomp
    converted_number1 = input_to_number(number1).to_f


    puts "\nPlease enter your second number:"
    number2 = gets.chomp
    converted_number2 = input_to_number(number2)

    # Check if the inputs were valid integers
    break if valid_number?(number1) && valid_number?(number2)

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
  result =  case operation
              when "+"  then converted_number1 + converted_number2
              when "-"  then converted_number1 - converted_number2
              when "*"  then converted_number1 * converted_number2
              when "/"  then converted_number1 / converted_number2
              when "%"  then converted_number1 % converted_number2
            end
  
  puts "#{number1} #{operation} #{number2} = #{result}"

  # Ask the user if they want to perform another operation
  loop do
    puts "\nDo you want to perform another operation? (y/n)"
    response = gets.chomp.downcase
    if response != "y" && response != "n"
      puts "Please enter 'y' or 'n'"
    elsif response == 'n'
      again = false
      puts "\nThank you for interacting with me!"
      break
    else
      break
    end
  end

  break if again == false
end
