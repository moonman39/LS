def prompt(message)
  puts "\n=> #{message}"
end

VALID_CHOICES = %w(rock paper scissors)
def check_user_choice(user)
  VALID_CHOICES.include?(user)
end

def display_result(user, computer)
  if (user == 'rock' && computer == 'paper') ||
      (user == 'paper' && computer == 'scissors') ||
      (user == 'scissors' && computer == 'rock')
    'The computer won!'
  elsif (user == 'rock' && computer == 'scissors') ||
        (user == 'paper' && computer == 'rock') ||
        (user == 'scissors' && computer == 'paper')
    'You won!'
  else
    'You tied!'
  end
end

loop do
  # User Choice
  user_choice = nil
  loop do
    prompt "Choose one: #{VALID_CHOICES.join(", ")}"
    user_choice = gets.chomp.downcase
    break if check_user_choice(user_choice)
    prompt "Please enter a valid input"
  end

  # Computer Choice
  prompt "Computer is thinking..."
  sleep 2
  prompt "Thinking..."
  sleep 1.5

  computer_choice = VALID_CHOICES.sample

  # Check the Winner
  prompt "You chose #{user_choice}."
  sleep 1.5
  prompt "The computer chose..."
  sleep 1.5
  prompt computer_choice.to_s
  sleep 1.5
  prompt display_result(user_choice, computer_choice).to_s

  # Play Again?
  sleep 1.5
  play_again = true
  loop do
    prompt "Do you want to play again? (y/n)"
    response = gets.chomp.downcase
    case response
    when 'n'
      play_again = false
      break
    when 'y'
      break
    end
    prompt "Please enter 'y' or 'n'"
  end

  break if play_again == false
end

prompt "Thanks for playing!"
