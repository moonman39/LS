def prompt message
  puts message
end

def valid_input? measurement
  loop do
    print "\n#{measurement} (in meters): "
    measurement = gets.chomp
  
    break if measurement.to_i.to_s == measurement && measurement.to_i.positive?
    prompt "\nPlease enter a valid, positive integer"
  end

  measurement.to_i
end

prompt "Please enter the length and width of a room in meters."
sleep 2

length = "Length"
length = valid_input?(length)

width = "Width"
width = valid_input?(width)

square_meters = length.to_f * width
square_feet = (square_meters * 10.7639).round(2)

prompt "The area of the room is #{square_meters} square meters (#{square_feet} square feet)"