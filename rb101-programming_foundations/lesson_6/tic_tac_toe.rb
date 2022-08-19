require 'pry'

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                [[1, 5, 9], [3, 5, 7]]

# Puts a message to the console
def prompt(message)
  puts message
end

# Displays the board each round
#   - takes in a key from the board variable initialized below
# rubocop: disable Metrics/MethodLength
def display_board(board)
  system 'clear'
  puts "You're #{PLAYER_MARKER}.  Computer is #{COMPUTER_MARKER}"
  puts ""
  puts "     |     |"
  puts "  #{board[1]}  |  #{board[2]}  |  #{board[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{board[4]}  |  #{board[5]}  |  #{board[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{board[7]}  |  #{board[8]}  |  #{board[9]}"
  puts "     |     |"
  puts ""
end
# rubocop: enable Metrics/MethodLength


# Initializing the board
#   - each board slot is a key/value pair, initially set to a space
def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def joiner(array, delimiter=", ", word='or')
  case array.size
  when 0 then ''
  when 1 then array.first
  when 2 then array.join(" #{word} ")
  else
    array[-1] = "#{word} #{array.last}"
    array.join(delimiter)
  end
end

def empty_squares(board)
  board.keys.select { |num| board[num] == INITIAL_MARKER }
end

def chosen_squares(board)
  board.keys.select { |num| board[num] != INITIAL_MARKER }.sort
end

# Prompt the user for an input
def player_places_piece!(board)
  square = nil
  loop do
    prompt "Choose a position to place a piece: #{joiner(empty_squares(board))}"
    square = gets.chomp.to_i

    break if empty_squares(board).include?(square)

    prompt "Sorry, that's not a valid choice"
  end
  
  board[square] = PLAYER_MARKER
end


def find_at_risk_square(line, board, marker)
  if board.values_at(*line).count(marker) == 2
    board.select{|k,v| line.include?(k) && v == INITIAL_MARKER}.keys.first
  else
    nil
  end
end

def five_chosen?(board)
  board[5] != INITIAL_MARKER
end

def computer_places_piece!(board)
    square = nil

    WINNING_LINES.each do |line|
      square = find_at_risk_square(line, board, COMPUTER_MARKER)
      break if square
    end

    if !square
      WINNING_LINES.each do |line|
        square = find_at_risk_square(line, board, PLAYER_MARKER)
        break if square
      end
    end
    
    if !square && five_chosen?(board)
      square = empty_squares(board).sample
    elsif !square
      square = 5
    end
  
    board[square] = COMPUTER_MARKER
end



def board_full?(board)
  empty_squares(board).empty?
end

def someone_won?(board)
  !!detect_winner(board)
end

def detect_winner(board)
  WINNING_LINES.each do |line|
    if board[line[0]] == PLAYER_MARKER &&
       board[line[1]] == PLAYER_MARKER &&
       board[line[2]] == PLAYER_MARKER
      return 'Player'
    elsif board[line[0]] == COMPUTER_MARKER &&
          board[line[1]] == COMPUTER_MARKER &&
          board[line[2]] == COMPUTER_MARKER
      return 'Computer'
    end
  end
  nil
end

def update_score(winner, array)
  case winner
  when "Player" then array[0] += 1
  when "Computer" then array[1] += 1
  end
end

def who_goes_first?
  first = nil
  loop do
    prompt "Press 1 to go first or 2 to go second"
    choice = gets.chomp.to_i
    if choice == 1
      first = "player"
      break
    elsif choice == 2
      first = 'computer'
      break
    end
    prompt "Please enter 1 or 2"
  end
  first
end

score_array = [0, 0]
loop do
  board = initialize_board
  display_board(board)

  loop do
    player_places_piece!(board)
    computer_places_piece!(board) if !someone_won?(board)
    display_board(board)
    break if someone_won?(board) || board_full?(board)
  end

  round_winner = detect_winner(board)

  if someone_won?(board)
    prompt "#{round_winner} won!"
    sleep 1.5
  else
    prompt "It's a tie!"
    sleep 1.5
  end

  update_score(round_winner, score_array)

  break if score_array.any? { |score| score == 5 }
  prompt "The score is Player: #{score_array.first} Computer: #{score_array.last}"

  sleep 2
end

prompt "Thanks for playing Tic Tac Toe, goodbye!"
