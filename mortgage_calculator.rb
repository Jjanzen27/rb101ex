require 'yaml'
MESSAGES = YAML.load_file('mortgage_calculator_messages.yml')

def messages(message)
  MESSAGES[message]
end

def prompt(message)
  puts("=> #{message}")
end

def valid_number?(num)
  num.to_f > 0
end

prompt(messages('welcome'))

loop do
  principal = ''
  loop do
    prompt(messages('mortgage_amount'))
    principal = gets.chomp.to_i
    if valid_number?(principal) == false
      prompt(messages('invalid_mortgage_amount'))
    else break
    end
  end

  interest_rate = ''
  loop do
    prompt(messages('interest_rate'))
    prompt(messages('interest_rate_examples'))
    interest_rate = gets.chomp.to_f
    if valid_number?(interest_rate) == false
      prompt(messages('invalid_interest_rate'))
    else break
    end
  end

  monthly_interest_rate = interest_rate * 0.01 / 12

  years = ''
  loop do
    prompt(messages('mortgage_length'))
    years = gets.chomp.to_i
    if valid_number?(years) == false
      prompt(messages(invalid_mortgage_length))
    else break
    end
  end

  number_of_months = years * 12

  monthly_payment = principal * (monthly_interest_rate /
  (1 - (1 + monthly_interest_rate)**(-number_of_months)))

  prompt("For a $#{principal} mortgage with a #{interest_rate} APR and a #{years} year term length:")
  prompt(messages("monthly_payment"))
  prompt("$#{format('%02.2f', monthly_payment)}.")
  prompt(messages("total_mortgage"))
  prompt("$#{format('%02.2f', monthly_payment * number_of_months)}")

  prompt(messages('calculate_again'))
  prompt(messages('calculate_again_intructions'))
  answer = gets.chomp.downcase
  break unless ['y', 'yes'].include?(answer.downcase)
  system('clear') || system('cls')
end

prompt(messages('goodbye'))
