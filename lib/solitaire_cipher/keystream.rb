module Keystream

  def start_deck()
  	@deck = (1..52).to_a + ['A', 'B']
  end

  def deck
    @deck
  end

  def key_deck(deck)

  end

  def keystream(length)
    deck = @deck.dup
    result =[]
    while result.length != length
      deck = self.move_a
      deck = self.move_b
      deck = self.triple_cut
      deck = self.count_cut
      letter = self.get_letter(deck)
      result << letter unless letter.nil?
    end
    result
  end

  def get_letter(deck)
    first = deck.first
    first = 53 if first.instance_of? String
    letter_int = deck[first]
    if letter_int.instance_of? String
      nil
    else
      letter_int -= 26 if letter_int > 26
      (letter_int + 64).chr
    end
  end

  def move_a
    index = @deck.index('A')
    move_down( index, 'A')
  end

  def move_b
  	2.times do 
  	  index = @deck.index("B")
  	  @deck = move_down(index, 'B')
  	end
  	deck
  end

  def triple_cut
    b = @deck.index("B")
    a = @deck.index("A")
    #Took this from previous ruby quiz
    a, b = b, a if a > b
    @deck.replace([@deck[(b+1)..-1],
                  @deck[a..b],
                  @deck[0...a]
                 ].flatten)
    @deck
  end

=begin
  Perform a count cut using the value of the bottom card. 
  Cut the bottom card's value in cards off the top of the 
  deck and reinsert them just above the bottom card. 
  This changes our deck to:
  2 3 4 ... 52 A B 1  (the 1 tells us to move just the B)
=end

  def count_cut
    last = @deck[-1].to_i
    @deck[-1..-1] = [@deck[0...last], @deck[-1]].flatten
    last.times {@deck.shift}
    @deck
  end


  def move_down(index, last=nil)
  	if index == @deck.size - 1
  	  @deck[1..1] = @deck[index], @deck[1]
  	  @deck.pop
  	else
  	  @deck[index+1], @deck[index] = @deck[index], @deck[index+1]
  	end
  	@deck
  end

end