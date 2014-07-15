#Tests for cipher
require './lib/solitaire_cipher'
def check(title, expected, actual)
  if expected == actual
  	puts "#{title}: Ok"
  else
  	raise "Failing test #{expected} does not equal #{actual}"
  end
end

test_string = "CLEPK HHNIY CFPWH FDFEH"
blank_string = "This is a test string"

cipher =SolitaireCipher.new
deck = cipher.start_deck
check("Initialize deck", (1..52).to_a + ['A', 'B'], cipher.start_deck)
check("Move A", (1..52).to_a + ['B', 'A'], cipher.move_a(deck))
a_deck = cipher.move_a(cipher.start_deck)
check("Move B", [1 ,'B', 2], cipher.move_b(a_deck)[0..2])
