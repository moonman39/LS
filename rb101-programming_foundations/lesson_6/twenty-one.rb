# Pseudo-Code
# 1. Initialize deck
# 2. Deal cards to player and dealer
# 3. Player turn: hit or stay
#   - repeat until bust or "stay"
# 4. If player busts, dealer wins
# 5. Dealer turn: hit or stay
#   - repeat until total >= 17
# 6. If dealer bust, player wins.
# 7. Compare cards and declare winner.

# Data Stuctures
deck = [['2', 'H'], ['3', 'H'], ['4', 'H'], ['5', 'H'], ['6', 'H'], ['7', 'H'], ['8', 'H'], ['9', 'H'],
        ['10', 'H'], ['Jack', 'H'], ['Queen', 'H'], ['King', 'H'], ['Ace', 'H'], ['2', 'S'], ['3', 'S'], ['4', 'S'], 
        ['5', 'S'], ['6', 'S'], ['7', 'S'], ['8', 'S'], ['9', 'S'], ['10', 'S'], ['Jack', 'S'], ['Queen', 'S'], 
        ['King', 'S'], ['Ace', 'S'], ['2', 'D'], ['3', 'D'], ['4', 'D'], ['5', 'D'], ['6', 'D'], ['7', 'D'], 
        ['8', 'D'], ['9', 'D'], ['10', 'D'], ['Jack', 'D'], ['Queen', 'D'], ['King', 'D'], ['Ace', 'D'], ['2', 'C'], 
        ['3', 'C'], ['4', 'C'], ['5', 'C'], ['6', 'C'], ['7', 'C'], ['8', 'C'], ['9', 'C'], ['10', 'C'], 
        ['Jack', 'C'], ['Queen', 'C'], ['King', 'C'], ['Ace', 'C']]

FACE_CARDS = %w(Jack Queen King)

def prompt message
  puts "\n=> #{message}"
end

def random_card deck
  card = deck.sample
  deck.delete(card)
  card.first
end

def initial_deal player_cards, dealer_cards, deck
  2.times do
    player_cards << random_card(deck)
    dealer_cards << random_card(deck)
  end
end

def deal card_set, deck
  card_set << random_card(deck)
end

def hit_or_stay
  choice = nil
  loop do
    prompt "Hit or stay?"
    choice = gets.chomp.downcase
    break if choice == 'hit' || choice == 'stay'
  end
  choice
end

def initial_player_display card_set
  print "\n=> Your cards are "
  sleep 1.5
  print "#{card_set.first} "
  sleep 1.5
  print "and #{card_set.last}"
  puts ""
end


def initial_dealer_display card_set
  prompt "The Dealers cards are #{card_set.first} and an unknown card"
end

def display_player_hand card_set
  prompt "Your cards are #{card_set.join(" and ")}"
end

def display_dealer_hand card_set
  prompt "The Dealer's cards are #{card_set.join(" and ")}"
end

def card_to_number card
  if card.to_i.between?(2, 10)
    card.to_i
  elsif FACE_CARDS.include?(card)
    10
  else
    11
  end
end

def total card_set
  sum = 0
  card_set.each { |card| sum += card_to_number(card) }

  if sum > 21 && card_set.include?("Ace")
    aces = card_set.count("Ace")
    until sum < 21 || aces == 0
      sum -= 10
      aces -= 1
    end
  end

  sum
end

def busted? card_set
  total(card_set) > 21
end

def blackjack? card_set
  total(card_set) == 21
end

def who_won? player_cards, dealer_cards
  if blackjack?(player_cards) && !blackjack?(dealer_cards)
    prompt "Congrats, you won!"
  elsif !busted?(player_cards) && busted?(dealer_cards)
    prompt "Congrats, you won!"
  elsif total(player_cards) == total(dealer_cards)
    prompt "It's a tie!"
  else
    prompt "The Dealer won!"
  end
end

# Gameplay
loop do
  deck = [['2', 'H'], ['3', 'H'], ['4', 'H'], ['5', 'H'], ['6', 'H'], ['7', 'H'], ['8', 'H'], ['9', 'H'],
        ['10', 'H'], ['Jack', 'H'], ['Queen', 'H'], ['King', 'H'], ['Ace', 'H'], ['2', 'S'], ['3', 'S'], ['4', 'S'], 
        ['5', 'S'], ['6', 'S'], ['7', 'S'], ['8', 'S'], ['9', 'S'], ['10', 'S'], ['Jack', 'S'], ['Queen', 'S'], 
        ['King', 'S'], ['Ace', 'S'], ['2', 'D'], ['3', 'D'], ['4', 'D'], ['5', 'D'], ['6', 'D'], ['7', 'D'], 
        ['8', 'D'], ['9', 'D'], ['10', 'D'], ['Jack', 'D'], ['Queen', 'D'], ['King', 'D'], ['Ace', 'D'], ['2', 'C'], 
        ['3', 'C'], ['4', 'C'], ['5', 'C'], ['6', 'C'], ['7', 'C'], ['8', 'C'], ['9', 'C'], ['10', 'C'], 
        ['Jack', 'C'], ['Queen', 'C'], ['King', 'C'], ['Ace', 'C']]

  player_cards = []
  dealer_cards = []

  prompt "Welcome to Blackjack! Here we go..."
  sleep 1.5

  prompt "Dealing..."
  sleep 1.5
  initial_deal(player_cards, dealer_cards, deck)
  initial_dealer_display(dealer_cards)
  sleep 2
  initial_player_display(player_cards)

  loop do
    if blackjack?(player_cards)
      prompt "Blackjack!"
      break
    end
    
    choice = hit_or_stay
    break if choice == "stay"
    
    deal(player_cards, deck)
    
    if busted?(player_cards)
      prompt "You busted!"
      break
    elsif blackjack?(player_cards)
      prompt "Blackjack!"
      break
    end

    display_player_hand(player_cards)
    sleep 2
    prompt "Your total is #{total(player_cards)}"
  end

  display_dealer_hand(dealer_cards)
  sleep 2
  loop do

    if blackjack?(dealer_cards)
      prompt "Blackjack!"
      break
    elsif busted?(dealer_cards)
      prompt "The Dealer busted!"
      break
    elsif total(dealer_cards) > total(player_cards)
      break
    elsif total(dealer_cards) >= 17
      break
    end

    deal(dealer_cards, deck)
    display_dealer_hand(dealer_cards)
    sleep 2
    prompt "The Dealer's total is #{total(dealer_cards)}"
  end

  sleep 2
  who_won?(player_cards, dealer_cards)

  play_again = true
  loop do
    prompt "Do you want to play again? (y/n)"
    response = gets.chomp.downcase
    if response.start_with?('y')
      break
    elsif response.start_with?('n')
      play_again = false
      break
    end
  end

  break if play_again == false
end

prompt "Thanks for playing!"