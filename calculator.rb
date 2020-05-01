require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

def messages(message, lang='en')
  MESSAGES[lang][message]
end

def prompt(message)
  puts("=> #{message}")
end

def float?(input)
  /\d/.match(input) && /^\d*\.?\d*$/.match(input)
end

def clear_screen
  system('clear') || system('cls')
end

def operation_to_message(op)
  word = case op
         when '1'
           'Adding'
         when '2'
           'Subtracting'
         when '3'
           'Multiplying'
         when '4'
           'Dividing'
         end
  word
end

prompt(messages('welcome'))

name = ''
loop do
  name = gets.chomp

  if name.empty?
    prompt(messages('valid_name'))
  else
    break
  end
end

prompt(messages('greeting') + name + "!")

loop do
  number1 = ''
  loop do
    prompt(messages('number1'))
    number1 = gets.chomp

    if float?(number1)
      break
    else
      prompt(messages('invalid_number'))
    end
  end

  number2 = ''
  loop do
    prompt(messages('number2'))
    number2 = gets.chomp

    if float?(number2)
      break
    else
      prompt(messages('invalid_number'))
    end
  end

  prompt(messages('operator'))

  operator = ''
  loop do
    operator = gets.chomp

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt(messages('invalid_operator'))
    end
  end

  prompt("#{operation_to_message(operator)} the two numbers... ")

  result = case operator
           when '1'
             number1.to_f + number2.to_f
           when '2'
             number1.to_f - number2.to_f
           when '3'
             number1.to_f * number2.to_f
           when '4'
             number1.to_f / number2.to_f
           end

  prompt(messages('result'))
  puts result

  answer = ''
  loop do
    prompt(messages('repeat'))
    answer = gets.chomp
    if answer == 'y' || answer == 'yes'
      break
    elsif answer == 'n' || answer == 'no'
      break
    else
      prompt(messages('invalid_response'))
    end
  end

  if answer == 'y' || answer == 'yes'
    clear_screen
    next
  elsif answer == 'n' || answer == 'no'
    break
  end
end

prompt(messages('goodbye'))
