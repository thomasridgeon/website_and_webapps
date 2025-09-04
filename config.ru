# Load gems
require 'bundler'
Bundler.require

# Load environment variables
require 'dotenv/load'

#---app root------
APP_ROOT = File.expand_path(__dir__) unless defined?(APP_ROOT)
ENV['APP_ROOT'] ||= APP_ROOT
# This ensures APP_ROOT always points to your project root (website_and_webapps).
# This is to avoid some complications I was running into while trying to set my database_file in my journal_controller

# -----------------------------
# Classic Sinatra website
# -----------------------------
require File.join(APP_ROOT, 'controllers', 'homepage_controller')
require File.join(APP_ROOT, 'views', 'homepage_view')
require File.join(APP_ROOT, 'controllers', 'aboutme_controller')
require File.join(APP_ROOT, 'views', 'aboutme_view')
require File.join(APP_ROOT, 'controllers', 'projects_controller')
require File.join(APP_ROOT, 'views', 'projects_view')
require File.join(APP_ROOT, 'controllers', 'resume_controller')
require File.join(APP_ROOT, 'views', 'resume_view')
require File.join(APP_ROOT, 'controllers', 'sunbenefits_controller')
require File.join(APP_ROOT, 'views', 'sunbenefits_view')
require File.join(APP_ROOT, 'controllers', 'portcharges_controller')
require File.join(APP_ROOT, 'views', 'portcharges_view')
require File.join(APP_ROOT, 'controllers', 'solardcalculator_controller')
require File.join(APP_ROOT, 'views', 'solardcalculator_view')

# -----------------------------
# Modular Journal app
# -----------------------------
require File.join(APP_ROOT, 'controllers', 'journal_controller')
require File.join(APP_ROOT, 'views', 'journallandingpage_view')

# using Sinatra classic for the more “static” part of my site (home, about, resume, projects, etc.) and Sinatra modular for the journal app.
# this way, the journal app can be its own product inside my site.
# keeping the journal modular ensures cleaner separation — /journal is truly its own app, isolated from /.
# each app can have its own configuration (database, sessions, views, etc.)
# more scalable for if I add multiple other more complex apps (e.g., /journal, /shop, etc.

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
