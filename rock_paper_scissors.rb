VALID_CHOICES = %w(rock paper scissors lizard spock)
SHORT_CUTS = %w(r sc l p sp)

def prompt(message)
  puts("=> #{message}")
end

def clear_screen
  system('clear') || system('cls')
end

def win?(first, second)
  condition = {
    'rock': ['scissors', 'lizard'],
    'paper': ['rock', 'spock'],
    'scissors': ['paper', 'lizard'],
    'lizard': ['spock', 'paper'],
    'spock': ['rock', 'scissors']
  }
  condition[first.to_sym].include?(second)
end

def input_validation(input)
  if input == 'r' || input == 'rock'
    input = 'rock'
  elsif input == 'p' || input == 'paper'
    input = 'paper'
  elsif input == 'sc' || input == 'scissors'
    input = 'scissors'
  elsif input == 'l' || input == 'lizard'
    input = 'lizard'
  elsif input == 'sp' || input == 'spock'
    input = 'spock'
  else
    prompt("Invalid option!")
  end
end

def display_results(player, computer)
  if win?(player, computer)
    'You won!'
  elsif win?(computer, player)
    'Computer won!'
  else
    "It's a tie!"
  end
end

loop do
  player_score = []
  computer_score = []
  prompt("First to 5 points wins!!")
  loop do
    choice = ''
    loop do
      prompt("Choose one: #{VALID_CHOICES.join(', ')}")
      choice = gets.chomp

      if VALID_CHOICES.include?(choice) ||
         SHORT_CUTS.include?(choice)
        choice = input_validation(choice)
        break
      else
        prompt("That's not a valid choice.")
        prompt("Shortcuts include:
                'p' for paper
                'r' for rock
                'sc' for scissors
                'l' for lizard
                'sp' for spock'")
      end
    end

    computer_choice = VALID_CHOICES.sample

    prompt("You chose: #{choice}. Computer chose: #{computer_choice}")

    display_results(choice, computer_choice)

    if display_results(choice, computer_choice).include? 'Computer'
      computer_score << 1
    elsif display_results(choice, computer_choice).include? 'You'
      player_score << 1
    end

    prompt("The score is #{player_score.sum} to #{computer_score.sum}")

    if player_score.length == 5
      prompt("You win!")
      break
    elsif computer_score.length == 5
      prompt("Computer wins! Better luck next time")
      break
    end
  end

  answer = ''
  loop do
    prompt('Do you want to play again?')
    answer = gets.chomp.downcase
    if answer == 'y' || answer == 'yes'
      break
    elsif answer == 'n' || answer == 'no'
      break
    else
      puts "Invalid command! Type 'y' or 'n'"
    end
  end

  if answer == 'y' || answer == 'yes'
    clear_screen
    next
  elsif answer == 'n' || answer == 'no'
    break
  end
end

prompt('Play again soon!')
