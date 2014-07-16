require_relative './solitaire_cipher/keystream'
require_relative './solitaire_cipher/encrypter'
class SolitaireCipher
  include Keystream
  include Encrypter
end