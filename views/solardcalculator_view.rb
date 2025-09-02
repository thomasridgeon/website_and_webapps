#---Solar D Calculator Widget------------------
require 'erector'

class SolarDCalculatorPage < Erector::Widget
  needs :uv_index, :result_time
  # added variables that will hold the numerical values for the UV index from openuv, the current time, and the time calculated for optimal vitamin D

  def content
    html do
      head do
        title 'Solar D Calculator'
        meta(charset: 'UTF-8')
        meta(name: 'viewport', content: 'width=device-width, initial-scale=1.0')

        link(rel: 'preconnect', href: 'https://fonts.googleapis.com')
        link(rel: 'preconnect', href: 'https://fonts.gstatic.com', crossorigin: 'anonymous')
        link(rel: 'stylesheet', href: 'https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css')
        link(href: 'https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap',
             rel: 'stylesheet')

        # Custom font CSS
        style do
          rawtext <<-CSS
      html, body {
        font-family: 'Montserrat', sans-serif !important;
      }
          CSS
        end
      end
      body(class: 'font-sans bg-slate-100 flex justify-center min-h-screen p-5') do
        div(class: 'container bg-white p-10 rounded-xl shadow-2xl max-w-lg w-full text-center') do
          h1(class: 'text-3xl font-bold text-center text-slate-800 mb-8') { text 'Solar D Calculator' }

          if @result_time.nil? # #if nil, this means we will display the form for the initial GET request

            if @uv_index.nil? || @uv_index <= 0
              p(class: 'text-lg text-red-600 mb-6') do
                text "The UV index is currently too low(#{@uv_index}) to synthesize vitamin D."
              end # end of UV too low message
            else
              p(class: 'text-lg font-semibold text-blue-700 mb-6') { 'The current UV index at your location is' }
              p(class: 'text-5xl font-extrabold text-blue-800 mb-6') { @uv_index }

              form(action: '/solardcalculator', method: 'post') do
                input(type: 'hidden', name: 'uv_index', value: @uv_index)
                # here we add a hiden input to pass on the UV index to the POST request

                div(class: 'mb-6') do
                  label('Age', for: 'age', class: 'block text-sm font-medium text-gray-700 mb-2')
                  input(type: 'number', id: 'age', name: 'age', required: true, min: '1',
                        class: 'w-full p-3 border border-gray-300 rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500')
                end # end of age field

                div(class: 'mb-6') do
                  label('Fitzpatrick Skin Type', for: 'skin_type',
                                                 class: 'block text-base font-medium text-gray-700 mb-2')
                  select(id: 'skin_type', name: 'skin_type', required: true,
                         class: 'block w-full py-2 px-3 text-base font-medium text-gray-700 mb-2') do
                    # The classes are applied to the SELECT tag, as most browsers ignore them on OPTION tags.
                    option('Select your skin type:', value: '', disabled: true, selected: true)
                    option('Type I: Very Fair (always burns, does not tan)', value: '1')
                    option('Type II: Fair (burns easily, tans poorly)', value: '2')
                    option('Type III: Medium (sometimes burns, tans after initial burn)', value: '3')
                    option('Type IV: Olive (burns minimally, tans easily)', value: '4')
                    option('Type V: Brown (rarely burns, tans darkly easily)', value: '5')
                    option('Type VI: Very Dark (never burns, always tans darkly)', value: '6')
                  end
                end # end of skin type field

                p(class: 'text-base text-gray-700 mb-4') do
                  text "Based on your location and the current UV index, let's calculate the amount of time you need in the sun right now to get an optimal daily intake of vitamin D. This estimate assumes you're exposing your face, neck, arms, and legs (like in a T-shirt and shorts)."
                end # if I do not use {} directly with a string, and instead use do, then text, i need to close the text

                button(type: 'submit',
                       class: 'w-full py-3 px-4 bg-blue-600 hover:bg-blue-700 text-white font-bold rounded-lg shadow-md transition-colors duration-300') do
                  text 'Calculate Time Required in the Sun'
                end
              end
            end
          else # else we are on the POST request, so display the results
            p(class: 'text-lg font-semibold text-blue-700 mb-6') do
              text "To get 1,000 IU of Vitamin D, you'll need to be in the sun for:"
            end
            p(class: 'text-5xl font-extrabold text-blue-800 mb-6') do
              text "#{format('%.1f', @result_time).to_f} minutes"
            end
            # @d_time: This is an instance variable that holds the raw, calculated time in minutes from the post '/solarcalculator'
            # '%.1f' % @d_time: This is Ruby's string formatting operator. The %.1f is a format specifier that tells Ruby to take the number in @d_time and turn it into a string with exactly one decimal place.
            # .to_f: This is a method that converts the formatted string back into a floating-point number.
            # "#{...} minutes": This is a string interpolation. The #{} syntax takes the result of the inner expression (the formatted time) and inserts it directly into the string, resulting in a final output like "15.3 minutes".

            p(class: 'text-sm text-gray-500 mt-4') do
              text "Note: This is an estimate based on a UV index of #{@uv_index} and assumes at least 25% of your body is exposed. Remember to be cautious with sun exposure."
            end
          end # end of main if @result_time.nil?

          div(class: 'mt-8 p-6 bg-gray-100 rounded-lg text-left') do
            h3(class: 'text-xl font-bold text-gray-800 mb-2') { 'About the Calculation' }
            p(class: 'text-sm text-gray-700 mb-4') do
              text 'This model is based on research by Dr. Michael Holick, a leading expert on vitamin D. The app calculates the time needed to synthesize 1,000 IU, which is considered an optimal daily level by many health professionals.'
            end

            p(class: 'text-xs text-gray-500 mt-4') do
              text 'Primary research sources for this model include:'
              br
              text 'Holick, M. F. (2004). Vitamin D: A new look at the sunshine vitamin. Dermato-Endocrinology, 29(1), 209-218.'
              br
              text "Çakmak, T., Yıldız, R., Usta, G., & Yılmaz, A. E. (2021). Holick's Rule Implementation: Calculation of Produced Vitamin D from Sunlight Based on UV Index, Skin Type, and Area of Sunlight Exposure on the Body. International Journal of Energy Research, 45(13), 19576-19590."
            end
          end

          div(class: 'my-4 text-center') do
            a(href: '/sunbenefits', class: 'bg-white text-gray-700 text-base underline') do
              text 'Click here to learn more about the benefits of sun exposure'
            end
          end

          div(class: 'my-8 text-center') do
            a(href: '/projects',
              class: 'inline-block py-2 px-4 bg-blue-600 hover:bg-blue-700 text-white text-base font-bold rounded-lg shadow-md transition-colors duration-300') do
              text 'Return to Projects'
            end
          end

          div(class: 'my-8 text-center') do
            a(href: '/',
              class: 'inline-block py-2 px-4 bg-blue-600 hover:bg-blue-700 text-white text-base font-bold rounded-lg shadow-md transition-colors duration-300') do
              text 'Return to Homepage'
            end
          end
        end
      end
    end
  end
end
#---------------------------------------------
