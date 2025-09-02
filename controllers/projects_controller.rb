require_relative '../views/projects_view'
get '/projects' do
  ProjectsPage.new.to_html
end
