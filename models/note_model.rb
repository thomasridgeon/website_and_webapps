require 'sinatra/activerecord'
require 'openssl'
require 'base64'

ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || 'sqlite3:db/development.sqlite3')

class Note < ActiveRecord::Base # makes Note an activerecord model
  belongs_to :user # sets up a 1-1 relationship: each note belongs to a user. This allows for note.user to get the owner and user.notes for all the notes of a user.
  CIPHER_ALGO = 'aes-256-gcm' # defines encryption algorithm

  # encrypts a plaintext note using the given key
  def self.encrypt(plaintext, key) # a class method: I call it like Note.encrypt. it doesn't save anything to the DB yet, just returns a new note object with encrypted fields.
    cipher = OpenSSL::Cipher.new(CIPHER_ALGO).encrypt # creates a new AES cipher object in encryption mode
    cipher.key = key # sets the AES key derives from user password
    iv = cipher.random_iv # an initialization vector is a random value used along with the encryption key to make the same plaintext encrypt to different ciphertexts each time. It prevents identical messages from producing identical encrypted output.
    cipher.iv = iv # sets IV for encryption, without it AES encryption would be deterministic

    cipher.auth_data = ''
    ciphertext = cipher.update(plaintext) + cipher.final # encrypts the plaintext
    tag = cipher.auth_tag # generates authentication tag to verify integrity.

    # encodes the binary ciphertext, IV and tag so they can be stored as text in the database
    new( # returns a new note instance ready to save
      ciphertext: Base64.encoded64(ciphertext),
      iv: Base64.encode64(iv),
      tag: Base64.encode64(tag)
    )
  end

  def decrypt(key) # an instance method called on a saved note object to get the original plaintext
    decipher = OpenSSL::Cipher.new(CIPHER_ALGO).decrypt
    decipher.key = key
    decipher.iv = Base64.decode64(iv)
    decipher.auth_tag = Base64.decode64(tag)
    decipher.auth_data = ''

    ciphertext = Base64.decode64(self.ciphertext)
    # encryption produces binary data, which can’t be safely stored in a plain text database column
    # The note in the database is stored as text (because computers don’t like raw binary in a DB).
    # This line turns it back into the original “binary gibberish” that the computer can actually decrypt.
    decipher.update(ciphertext) + decipher.final
    # The update method feeds the binary ciphertext into the AES cipher in decryption mode.
    # Completes the decryption process and returns any remaining plaintext.
  end
end
