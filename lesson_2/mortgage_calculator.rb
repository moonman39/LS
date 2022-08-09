# Initializations
def calculate_payment(loan_amount, j, n)
  m = loan_amount * (j / (1 - (1 + j)**(-n)))
end

def prompt(message)
  puts "\n=> #{message}"
end

def integer?(number)
  number.to_i.to_s == number
end

def float?(number)
  number.to_f.to_s == number
end

def apr_to_monthly(apr)
  apr = apr / 100
  apr / 12
end

def years_to_months(years)
  years * 12
end

loan_amount = nil
apr = nil
loan_duration = nil
another_one = true




# Functionality
loop do
  loop do
    prompt "Please enter your loan amount"
    loan_amount = gets.chomp
    break if integer?(loan_amount) && loan_amount.to_i > 0
    prompt "Please enter a valid number"
  end
  loan_amount = loan_amount.to_i

  loop do
    prompt "Please enter your Annual Percentage Rate (APR)"
    apr = gets.chomp
    break if float?(apr) && apr.to_f > 0
    prompt "Please enter a valid APR."
    prompt "\nUse a decimal even if not needed"
  end
  apr = apr.to_f

  loop do
    prompt "Please enter the duration of your loan"
    loan_duration = gets.chomp
    break if integer?(loan_duration) && loan_duration.to_i > 0
    prompt "Please enter a valid number"
  end
  loan_duration = loan_duration.to_i

  monthly_interest_rate = apr_to_monthly(apr)
  loan_in_months = years_to_months(loan_duration)

  monthly_payment = calculate_payment(loan_amount, monthly_interest_rate, loan_in_months)

  prompt "Your monthly payment would be $#{monthly_payment.truncate(2)}."

  loop do
    prompt "Would you like to do another calculation? (Y/N)"
    response = gets.chomp.downcase
    if response == 'y' || response == 'n'
      another_one = false if response == 'n'
      break
    end
    prompt "Enter either 'Y' or 'N'"
  end

  break if another_one == false
end

prompt "\nThank you for interacting with me!"


