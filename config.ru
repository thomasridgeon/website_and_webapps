# Load gems
require 'bundler'
Bundler.require

# Load environment variables
require 'dotenv/load'

# -----------------------------
# Classic Sinatra website
# -----------------------------
require_relative 'controllers/homepage_controller'
require_relative 'views/homepage_view'
require_relative 'controllers/aboutme_controller'
require_relative 'views/aboutme_view'
require_relative 'controllers/projects_controller'
require_relative 'views/projects_view'
require_relative 'controllers/resume_controller'
require_relative 'views/resume_view'
require_relative 'controllers/sunbenefits_controller'
require_relative 'views/sunbenefits_view'
require_relative 'controllers/portcharges_controller'
require_relative 'views/portcharges_view'
require_relative 'controllers/solardcalculator_controller'
require_relative 'views/solardcalculator_view'

# -----------------------------
# Modular Journal app
# -----------------------------
require_relative 'controllers/journal_controller'
require_relative 'views/journallandingpage_view'
# -----------------------------
# Development-only tools
# -----------------------------
configure :development do
  require 'sinatra/reloader'
  register Sinatra::Reloader
  require 'pry-byebug'
end

#---------------------
# if i wanted to store session data in the server, i would use Rack::Session::Pool:

# use Rack::Session::Pool, {
# key: 'rack.session',
# expire_after: 3600, # 1 hour
# secure: true, # only send over HTTPS
# httponly: true # not accessible via JS
# }

# if I do not do this, that means all session data (user_id, derived_key, etc) is stored directly inside a cookie in the user's browser.
# with use Rack::Session::Pool, the browser only gets a random session ID, the actual session data is stored on the server, which is at least safer than storing in the broswer.
# so even if someone steals the cookie, they only get a meaningless session ID
# however, there are drawbacks to this approach.

# since i could not get activerecord session store to work, i am going the route of encrypted cookie:

#---mount session middleware------
use Rack::Session::Cookie,
    key: 'journal.session', # name of the cookie
    secret: ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }, # ensures tamper-proof and encrypted cookie
    httponly: true,                   # not accessible to JS
    secure: false,                    # set to false only for testing on localhost. must be true in prod (only over HTTPS)
    expire_after: 3600,               # 1 hour
    same_site: :strict,               # protects against CSRF
    coder: Rack::Session::Cookie::Base64::Marshal.new

# -----------------------------
# Mount apps with Rack::URLMap

# Classic app serves "/", "/about", etc.
# Journal app mounted at "/journal"
run Rack::URLMap.new(
  '/' => Sinatra::Application, # classic website
  '/journal' => JournalController # modular journal app
)
