require_relative '../views/resume_view'
get '/resume' do
  ResumePage.new.to_html
end
