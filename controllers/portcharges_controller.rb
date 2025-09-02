require_relative '../views/portcharges_view'

#---Rates for Port Charges----------------------
RATES = {
  'fas' => {
    '20ST' => 1221.98,
    '40ST' => 2443.96,
    '40HC' => 2661.32,
    '20RH' => 1328.93,
    '40RH' => 2657.85
  },
  'security_fee' => {
    '20ST' => 155.10,
    '40ST' => 310.20,
    '40HC' => 310.20,
    '20RH' => 105.75,
    '40RH' => 211.50
  },
  'hazard' => {
    '20ST' => 118.68,
    '40ST' => 259.09,
    '40HC' => 259.09

  },
  'unstuffing' => {
    '20ST' => 528.75,
    '40ST' => 1075.50,
    '40HC' => 1075.50

  },
  'plugs_daily_rate' => {
    '20RH' => 115.15,
    '40RH' => 230.30
  }
}
# In Ruby, => is a special operator most commonly used to define key-value pairs within a hash. It separates the key from its corresponding value.
# the curly braces {} are used to define a hash. A hash is a fundamental data structure in Ruby that stores data in key-value pairs. It's a perfect way to organize and look up information.

#---Port Charges Get Route------------

get '/portcharges' do
  # The keyword get is an HTTP method. It's the standard way for a web browser to request a resource from a web server. When you type a URL into a browser and press Enter, the browser sends a GET request.
  PortChargesCalculatorPage.new.to_html
  # This line creates a new instance of the PortChargesCalculatorPage class. This is the class you defined using Erector to build the HTML for your page.
  # .to_html: This method is called on the new PortChargesCalculatorPage object. It's an Erector method that takes all of the Ruby methods you defined in the content block (html, head, body, etc.) and converts them into a single string of valid HTML. This HTML string is what the web browser will receive and render as the homepage.
end

#---Port Charges Post Route-----------

post '/calculate' do
  # This section of code is a Sinatra route that handles the form submission and performs the initial part of the calculation. It's the logic that runs on the server after a user clicks the "Calculate Charges" button on the form.
  # The post '/calculate' route is for submitting data to the server. This happens when the user fills out the form and clicks the "Calculate Charges" button. The form packages up all the user's input and sends it to the URL specified in the form's action attribute.
  num_containers = params[:num_containers].to_i
  # num_containers = params[:num_containers].to_i: This line retrieves the value from the "Number of Containers" input field.
  # params: Sinatra automatically collects all the data submitted by a form and puts it into a hash named params.
  # params[:num_containers]: This accesses the value from the form field that had the name attribute of 'num_containers'.
  container_type = params[:container_type]
  # This line does the same for container type, as the line above it did for number of containers, except the value is already a string, so no conversion is needed.
  total_charge = 0.0
  # total_charge = 0.0: This line initializes a variable to store the final calculated total. It's set to 0.0 to ensure it's a floating-point number, which is necessary for precise monetary calculations.
  breakdown = {}
  # I want to add a breakdown of each charge also, so I need to create a hash {} for the breakdown, and now within each of the if conditions, I will save the calculated charge to this new breakdown hash.

  if params['fas'] == 'on'
    # if params[:fas] == 'on': This is a conditional statement that checks if the "FAS" checkbox was selected in the form. When a checkbox is checked, its value is sent as 'on'.
    rate = RATES['fas'][container_type]
    # rate = RATES['fas'][container_type]: If the checkbox was checked, this line looks up the specific charge rate. It first accesses the RATES hash with the key 'fas', and then it uses the container_type (e.g., '20ST') as the key to find the corresponding rate.
    charge_amount = num_containers * rate
    # charge_amount =: This is a variable assignment. It creates a new variable named charge_amount and gives it a value.
    total_charge += charge_amount if rate
    # total_charge: This is the variable that keeps a running total of all the charges.
    # +=: This is a shorthand operator. It means "add the value on the right to the variable on the left and reassign the result to the variable." So, total_charge += charge_amount is the same as writing total_charge = total_charge + charge_amount.
    breakdown['FAS'] = charge_amount if rate
    # breakdown: This is the new hash you created to store the breakdown of charges.
    # ['FAS'] =: This is the syntax for adding a new key-value pair to a hash. The key is 'FAS' (a string you chose to describe the charge), and the value is the calculated charge_amount.
  end

  if params['security_fee'] == 'on'
    rate = RATES['security_fee'][container_type]
    charge_amount = num_containers * rate
    total_charge += charge_amount if rate
    breakdown['Security Fee'] = charge_amount if rate
  end

  if params['hazard'] == 'on'
    rate = RATES['hazard'][container_type]
    charge_amount = num_containers * rate
    total_charge += charge_amount if rate
    breakdown['Hazard'] = charge_amount if rate
  end

  if params['unstuffing'] == 'on'
    rate = RATES['unstuffing'][container_type]
    charge_amount = num_containers * rate
    total_charge += charge_amount if rate
    breakdown['Unstuffing'] = charge_amount if rate
  end

  if params['plugs_daily_rate'] == 'on'
    days = params['plugs_days'].to_i
    if days > 0
      rate = RATES['plugs_daily_rate'][container_type]
      charge_amount = num_containers * days * rate
      total_charge += charge_amount if rate
      breakdown['Plugs Daily Rate'] = charge_amount if rate
    end
  end

  result_data = {
    total: total_charge,
    breakdown: breakdown
  }
  PortChargesCalculatorPage.new(result_data).to_html
end

# Creating the Data Package:
# result_data =: This line creates a new variable named result_data.
# { ... }: The curly braces create a new hash, which is a collection of key-value pairs. This hash acts as a single package to hold all the information you want to pass to the page.
# total: total_charge: This creates the first key-value pair.total_charge is the variable holding the final calculated total. Its value is assigned to the total: key.
# breakdown: breakdown: This creates the second key-value pair.
# breakdown: This is the variable holding the hash you created that contains the details of each individual charge. This means your result_data hash holds another hash as one of its values.

# Passing the Data to the Page:
# PortChargesCalculatorPage.new(...): This creates a new instance of your PortChargesCalculatorPage class. When you call .new, it automatically runs the initialize method inside your class.
# (result_data): This is the argument you are passing to the initialize method. The entire hash you just created is passed as the result parameter to that method, which then assigns it to the @result instance variable.
#-----------------------------------------------
