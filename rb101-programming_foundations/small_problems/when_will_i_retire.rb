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
  
    break if input.to_i.to_s == input && input.to_i.positive?
    prompt "Please enter a valid, positive number"
  end

  input.to_i
end

age = valid_input?(age, "What is your age?")
retirement_age = valid_input?(retirement_age, "At what age would you like to retire?")

current_year = Time.now.year
years_left = retirement_age - age
future_year = years_left + current_year


if age < retirement_age
  prompt "It's #{current_year}.  You will retire in #{future_year}."
  prompt "You only have #{years_left} years of work to go!"
else
  prompt "Congrats on your retirement!"
end