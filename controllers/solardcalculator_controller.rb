require_relative '../views/solardcalculator_view'

#---API Keys------------------------------------
OPENUV_API_KEY = ENV['OPENUV_API_KEY']
#-----------------------------------------------
#---Solar D Calculator Get Route-------------
get '/solardcalculator' do
  ip = request.ip
  location_response = HTTParty.get("http://ip-api.com/json/#{ip}")
  # Make an API call to ip-api to get the location data.
  # No API key is required.

  if location_response.success? && JSON.parse(location_response.body)['status'] == 'success'
    location_data = JSON.parse(location_response.body)
    lat = location_data['lat']
    lng = location_data['lon']
  # Parse the JSON response from ip-api to get the latitude and longitude.
  else
    # Fallback to hardcoded Barabdos coordinates if IP-API fails, which it does when testing in localhost because localhost resolves to 127.0.0.1, based on which IP-API cannot determine a geographic location.
    lat = 13.1939
    lng = -59.5432
  end

  #---Debugging------------------------------
  puts "Latitude: #{lat}"
  puts "Longitude: #{lng}"
  #------------------------------------------

  openuv_response = HTTParty.get(
    "https://api.openuv.io/api/v1/uv?lat=#{lat}&lng=#{lng}",
    headers: { 'x-access-token' => OPENUV_API_KEY }
  )

  #---More debugging---------------------------
  puts "OpenUV API Response Status: #{openuv_response.code}"
  puts "OpenUV API Response Body: #{openuv_response.body}"
  #-------------------

  if openuv_response.success?
    # Adds error handling. Check if the OpenUV API call was successful before trying to parse the body.
    openuv_data = JSON.parse(openuv_response.body)
    uv_index = openuv_data ['result']['uv']
    # Parse the JSON response from OpenUV to get the UV index.

    #---Even more debugging---------------
    puts '===OPENUV DEBUG INFO==='
    puts "Full response: #{openuv_data.inspect}"
    puts "UV index value: #{uv_index}"
    puts "UV index class: #{uv_index.class}"
    puts "UV index <= 0? #{uv_index <= 0}"
    puts "Current time: #{Time.now}"

    SolarDCalculatorPage.new(uv_index: uv_index, result_time: nil).to_html
    # Render the page using the Erector widget and pass the calculated UV index to it.
    # We pass nil to `result_time` on the GET request so the form is displayed.
  else
    'Error: Could not retrieve UV data from OpenUV API. Please check your API key or try again later'
  end
end
#---------------------------------------------------

#---Solar D Calculator Post Route--------------------
post '/solardcalculator' do
  # This is the POST route that handles the calculation

  puts "POST params: #{params.inspect}"
  # Confirm the POST is being hit and parameters are passed correctly. Watch the console while the form is submitted.

  uv_index = params['uv_index']&.to_f
  age = params['age']&.to_i
  skin_type = params['skin_type']&.to_i
  # Here we get the variables from the form submission
  # #params: Sinatra automatically collects all the data submitted by a form and puts it into a hash named params.
  # &.to_f and &.to_i: These are used to safely call a method on an object. The &. operator checks if the object is nil before trying to call the method. If the object is nil, it just returns nil instead of causing an error.

  # Check if any of the required parameters are missing (nil).
  # If so, handle the error gracefully instead of crashing.
  redirect '/solardcalculator' if uv_index.nil? || age.nil? || skin_type.nil?

  #----Skin type multipliers and age factors--------------------

  # widely cited scientific model, often referenced in publications by Dr. Michael Holick, a leading vitamin D researcher, provides a practical rule of thumb. This model assumes that under optimal conditions (clear skies, midday sun, summer, 25% of the body exposed):

  # 10-15 minutes of sun exposure** on the arms and legs at a UV index of **7** can produce approximately **1,000 IU** of vitamin D.

  # **Type I (Very Fair):** Requires slightly less time, roughly **80%** of the baseline.
  # **Type II (Fair):** The baseline for the calculation, at **100%**.
  # **Type III (Medium):** Requires about **20-30% more** time.
  # **Type IV (Olive):** Requires about **50-70% more** time.
  # **Type V (Brown):** Requires **2-3 times more** time.
  # **Type VI (Very Dark):** Requires **5-10 times more** time.

  # Scientific studies have shown that the skin's capacity to produce vitamin D decreases with age. By the time a person is 70-80 years old, their skin's ability to produce vitamin D from sunlight is about **two to three times less** than that of a young adult.
  # **Ages 1-30:** No reduction factor.
  # **Ages 30-60:** A progressive reduction, perhaps a linear decrease to a factor of 0.75 by age 60.
  # **Ages 60+:** A continued, more pronounced reduction, to a factor of 0.50 or less by age 70 or 80.

  # Fitzpatrick Skin Type Multipliers
  skin_multipliers = {
    1 => 0.8,
    2 => 1.0,
    3 => 1.25,
    4 => 1.6,
    5 => 2.5,
    6 => 7.5
  }

  # Age-Related Scaling
  age_factor = 1.0
  if age >= 60
    # For ages 60+, reduction to a factor of 0.5 or less.
    # We use a linear decrease from 0.75 at age 60 to 0.5 at age 80
    age_factor = if age > 80
                   0.5
                 else
                   0.75 - ((age - 60) * (0.25 / 20.0))
                 end
  elsif age > 30
    # For ages 30-60, a progressive reduction to 0.75 by age 60
    age_factor = 1.0 - ((age - 30) * (0.25 / 30.0))
  end

  if uv_index.nil? || uv_index <= 0
    required_sun_time = nil
    # "If there’s no UV index, or if it’s nighttime (UV = 0), don’t try to calculate — just set required_sun_time = nil."

  else

    # Calculate the required sun exposure time in minutes
    # Formula: Time (minutes) = (10 minutes) * Fitzpatrick Multiplier) * (Age Factor) * (7/ Current UV Index)
    required_sun_time = 10.0 * skin_multipliers[skin_type] * age_factor * (7.0 / uv_index)
  end

  # Render the page with the calculation result
  SolarDCalculatorPage.new(uv_index: uv_index, result_time: required_sun_time).to_html
end
#----------------------------------
