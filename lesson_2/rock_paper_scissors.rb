def prompt(message)
  puts "\n=> #{message}"
end

def check_user_choice(user_choice)
  user_choice == 'rock' || user_choice == 'paper' || user_choice == 'scissors'
end

def random_computer_choice
  %w(rock paper scissors).sample
end

def winner_check(user_choice, computer_choice)
  if user_choice == 'rock' && computer_choice == 'paper'
    'The computer won!'
  elsif user_choice == 'rock' && computer_choice == 'scissors'
    'You won!'
  elsif user_choice == 'paper' && computer_choice == 'rock'
    'You won!'
  elsif user_choice == 'paper' && computer_choice == 'scissors'
    'The computer won!'
  elsif user_choice == 'scissors' && computer_choice == 'rock'
    'The computer won!'
  elsif user_choice == 'scissors' && computer_choice == 'paper'
    'You won!'
  else
    'You tied!'
  end
end

loop do
  user_choice = nil
  loop do
    prompt "Do you choose rock, paper, or scissors?"
    user_choice = gets.chomp.downcase
    break if check_user_choice(user_choice)
    prompt "Please enter a valid input"
  end

  prompt "Computer is thinking..."
  sleep 2
  prompt "Thinking..."
  sleep 1.5

  computer_choice = random_computer_choice
  prompt "You chose #{user_choice}."
  sleep 1.5
  prompt "The computer chose..."
  sleep 1.5
  prompt "#{computer_choice}"
  sleep 1.5
  prompt "#{winner_check(user_choice, computer_choice)}"

  sleep 1.5
  play_again = true
  loop do
    prompt "Do you want to play again? (y/n)"
    response = gets.chomp.downcase
    if response == 'n'
      play_again = false
      break
    elsif response == 'y'
      break
    end
    prompt "Please enter 'y' or 'n'"
  end

  break if play_again == false
end

prompt "Thanks for playing!"
  
  

  