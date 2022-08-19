def prompt(message)
  puts "\n=> #{message}"
end

VALID_CHOICES = %w(rock paper scissors)
def check_user_choice(user)
  VALID_CHOICES.include?(user)
end

def win?(first, second)
  (first == 'rock' && second == 'paper') ||
    (first == 'paper' && second == 'scissors') ||
    (first == 'scissors' && second == 'rock')
end

def convert_input(input)
  case input
  when 'r' then 'rock'
  when 'p' then 'paper'
  when 's' then 'scissors'
  else input
  end
end

def display_result(user, computer)
  if win?(user, computer)
    'The computer won!'
  elsif win?(computer, user)
    'You won!'
  else
    'You tied!'
  end
end

# Gameplay Loop
computer_score = 0
user_score = 0
prompt "Rock, Paper, Scissors!! First to 3 wins.  Get ready..."

loop do
  # User Choice
  sleep 1.5
  user_choice = nil
  loop do
    prompt "Choose one: #{VALID_CHOICES.join(', ')}"
    user_choice = gets.chomp.downcase
    user_choice = convert_input(user_choice)
    break if VALID_CHOICES.include?(user_choice)
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
  result = display_result(user_choice, computer_choice)
  prompt result

  # Increment and Display Score
  if result.include?('computer')
    computer_score += 1
  elsif result == 'You won!'
    user_score += 1
  end
  prompt "The score is: You: #{user_score} Computer: #{computer_score}"

  break if user_score == 3 || computer_score == 3
end

prompt "Thanks for playing!"
