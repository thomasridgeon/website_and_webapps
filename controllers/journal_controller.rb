require 'sinatra/base'           # for creating a Sinatra controller class
require 'sinatra/activerecord'   # to interact with the database via ActiveRecord
require 'base64'                 # for encoding/decoding keys if you store them in session
require 'openssl'                # for AES encryption/decryption
require 'bcrypt'
require_relative '../models/user_model'
require_relative '../models/note_model'
require_relative '../views/signup_view'
require_relative '../views/login_view'

class JournalController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  enable :sessions
  # makes sure the controller is standalone and session enabled

  set :views, proc { File.join(root, '../views') }
  # in Sinatra, set is how you configure options for your app. :views tells Sinatra to look for template files- in my case, Erector widgets.
  # a proc in ruby is a saved chunk of code. it's like a sticky note with instructions that i hand to Sinatra, and sinatra will read it when it needs it.
  # So Sinatra sees the { File.join(root, "../views") } and says, whenever I need to know where the views folder is, I will run this proc
  # File.join is just the safe way to build file paths in ruby
end

#---helpers---
helpers do
  def current_user
    return unless session['user_id'] # ensures the rest only runs if there is a user_id in session

    @current_user ||= User.find_by(id: session['user_id']) # ||= is shorthand for @current_user = @current_user || User.find(session['user_id']
    # If @current_user is already set (not nil or false), Ruby keeps its current value.
    # If @current_user is nil (meaning it hasn’t been set yet in this request), Ruby runs User.find(session['user_id']) and assigns the result.
  end

  def derive_key(password, salt)
    OpenSSL::PKCS5.pbkdf2_hmac(
      password,
      salt,
      200_000, # iterations
      32, # key length in bytes
      'sha256'
    )
  end
end
#------------------

#---Login/Signup Routes-------------
get '/login' do
  LoginPage.new.to_html
end

post '/login' do
  user = User.find_by(username: params[:username])
  if user && user.authenticate(params[:password])
    session['user_id'] = user.id
    # store derived key in session for note encryption/decryption
    session['derived_key'] = Base64.encode64(derive_key(params[:password], user.salt))
    redirect '/journal/notes'
  else
    'Login failed'
  end
end

get '/signup' do
  SignupPage.new.to_html # pass sign up page to Erector
end

post '/signup' do
  user = User.new(username: params[:username], password: params[:password])
  user.salt = SecureRandom.hex(16)
  if user.save
    session['user_id'] = user.id
    session['derived_key'] = Base64.encode64(derive_key(params[:password], user.salt))
    redirect '/journal/notes'
  else
    'Signup failed'
  end
end

#---Notes Routes----------

get '/notes' do # list all notes
  halt 401, 'Not logged in' unless current_user
  @notes = current_user.notes
  NotesPage.new(@notes).to_html # pass notes into my Erector page
end

get '/notes/new' do # show the new note form
  halt 401, 'Not logged in' unless current_user
  NewNotePage.new.to_html # pass the new note form to my Erector
end

post '/notes' do # create a new encrypted note. here params have to be taken and saved to a DB. I don't need to render a page here to pass to Erector
  halt 401, 'Not logged in' unless current_user
  key = Base64.decode64(session['derived_key'])
  note = Note.encrypt(params[:body], key)
  note.user = current_user
  note.save
  redirect "/journal/notes/#{note.id}"
end

get '/notes/:id' do # show a single note (decrypted)
  halt 401, 'Not logged in' unless current_user
  note = current_user.notes.find(params[:id])
  key = Base64.decode64(session['derived_key'])
  @plaintext = note.decrypt(key)
  NotePage.new(@plaintext).to_html
end

get '/notes/:id/edit' do # show edit form
  halt 401, 'Not logged in' unless current_user
  note = current_user.notes.find(params[:id])
  EditNotePage.new(note).to_html
end

post '/notes/:id' do # update note (re-encrypt)
  halt 401, 'Not logged in' unless current_user
  note = current_user.notes.find(params[:id])
  key = Base64.decode64(session['derived_key'])
  note_encrypted = Note.encrypt(params[:body], key)
  note.update(
    ciphertext: note_encrypted.ciphertext,
    iv: note_encrypted.iv,
    tag: note_encrypted.tag
  )
  redirect "/journal/notes/#{note.id}"
end
