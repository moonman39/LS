def prompt message
  puts "\n=> #{message}"
end

def get_input message
  print "\n#{message}: "
end

def valid_input? input
  loop do
    get_input "What is the #{input}?"
    input = gets.chomp
  
    break if input.to_i.to_s == input && input.to_i.positive?
    prompt "Please enter a valid, positive number"
  end

  input.to_i
end

bill = "bill"
bill = valid_input?(bill)
tip_percentage = "tip percentage"

tip_percentage = valid_input?(tip_percentage)
tip = bill * tip_percentage.to_f / 100
total = (tip + bill).round(2)

prompt "The tip is $#{tip}"
prompt "The total is $#{total}"





