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
b_deck = cipher.move_b(cipher.move_a(cipher.start_deck))
triple_cut_deck = cipher.triple_cut(b_deck)
check("Triple Cut A", [52, 'A', 1], triple_cut_deck[51..-1])
check("Triple Cut B", ['B', 2, 3], triple_cut_deck[0..2])
count_cut = cipher.count_cut(triple_cut_deck)
check("Count Cut", ['A', 'B', 1 ], count_cut[51..-1])

