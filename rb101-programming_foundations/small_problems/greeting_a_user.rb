def prompt message
  puts "\n=> #{message}"
end

def get_input message
  print "\n=> #{message}: "
end

get_input "What is your name? "
name = gets.chomp

if name[-1] == "!"
  prompt "HELLO #{name.upcase}. WHY ARE WE SCREAMING?"
else 
  prompt "Hello #{name}."
end