SUITS = ['H', 'D', 'S', 'C']
VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King',
          'Ace']
FACE_CARDS = %w(Jack Queen King)

def initialize_deck
  VALUES.product(SUITS)
end

def prompt(message)
  puts "\n=> #{message}"
end

def random_card(deck)
  card = deck.sample
  deck.delete(card)
  card.first
end

def initial_deal(player_cards, dealer_cards, deck)
  2.times do
    player_cards << random_card(deck)
    dealer_cards << random_card(deck)
  end
end

def deal(card_set, deck)
  card_set << random_card(deck)
  prompt "The Dealer delt a #{card_set.last}"
  sleep 2
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

def initial_player_display(card_set)
  print "\n=> Your cards are "
  sleep 1.5
  print "#{card_set.first} "
  sleep 1.5
  print "and #{card_set.last} for a total of #{total(card_set)}"
  puts ""
end

def initial_dealer_display(card_set)
  prompt "The Dealers cards are #{card_set.first} and an unknown card"
end

def display_player_hand(card_set)
  prompt "Your cards are #{card_set.join(' and ')} for a total of #{total(card_set)}"
end

def display_dealer_hand(card_set)
  prompt "The Dealer's cards are #{card_set.join(' and ')} for a total of #{total(card_set)}"
end

def card_to_number(card)
  if card.to_i.between?(2, 10)
    card.to_i
  elsif FACE_CARDS.include?(card)
    10
  else
    11
  end
end

def total(card_set)
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

def busted?(card_set)
  total(card_set) > 21
end

def blackjack?(card_set)
  total(card_set) == 21
end

def dealer_check player_cards, dealer_cards
  if blackjack?(dealer_cards)
    prompt "Blackjack!"
    true
  elsif busted?(dealer_cards)
    prompt "The Dealer busted!"
    true
  elsif total(dealer_cards) > total(player_cards)
    true
  elsif total(dealer_cards) >= 17
    true
  end
end

def game_break? card_set
  if busted?(card_set)
    prompt "Busted!"
    true
  elsif blackjack?(card_set)
    prompt "Blackjack!"
    true
  else
    false
  end
end

def who_won? player_cards, dealer_cards
  if busted?(player_cards) || (total(player_cards) < total(dealer_cards) && !busted?(dealer_cards))
    prompt "The Dealer won!"
  elsif busted?(dealer_cards) || total(player_cards) > total(dealer_cards)
    prompt "You won!"
  elsif total(player_cards) == total(dealer_cards)
    prompt "It's a tie!"
  end
end

def play_again?
  play_again = true
  loop do
    sleep 2
    prompt "Do you want to play again? (y/n)"
    response = gets.chomp.downcase
    if response.start_with?('y')
      break
    elsif response.start_with?('n')
      play_again = false
      break
    end
  end
  play_again
end

# Gameplay
loop do
  system 'clear'
  deck = initialize_deck
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
    break if game_break?(player_cards)
    break if hit_or_stay == 'stay'

    deal(player_cards, deck)

    break if game_break?(player_cards)

    display_player_hand(player_cards)
    sleep 2
  end

  display_dealer_hand(dealer_cards) unless busted?(player_cards)
  sleep 2
  loop do
    break if game_break?(dealer_cards) || total(dealer_cards) >= 17 || busted?(player_cards)

    deal(dealer_cards, deck)
    display_dealer_hand(dealer_cards)
    sleep 2
  end

  sleep 2

  who_won?(player_cards, dealer_cards)
  break if !play_again?
end

prompt "Thanks for playing!"
