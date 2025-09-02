require_relative '../views/sunbenefits_view'
get '/sunbenefits' do
  SunBenefitsPage.new.to_html
end
