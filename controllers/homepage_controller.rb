require_relative '../views/homepage_view'
get '/' do
  HomePage.new.to_html
end
