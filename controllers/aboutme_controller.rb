require_relative '../views/aboutme_view'
get '/about' do
  AboutPage.new.to_html
end
